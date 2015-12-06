require 'rest-client'
require 'json'

class LtaApi
  Base_url = "http://datamall.mytransport.sg/ltaodataservice.svc/"
  Account_key = ENV['DATAMALL_ACCOUNT_KEY']
  User_id = ENV['DATAMALL_USER_ID']

  def getDataFor(service) 
    businfo = fetchInfoAbout(service)

    geoinfo = ""
    if service.include?("BusStop")
      geoinfopath = "data/BusStop_Oct2015/busstops.json"
      geoinfo = JSON.parse(File.read(geoinfopath))
    end

    businfo.each do |b|
      if service.include?("Info") 
        store_busline(b, service)
      elsif service.include?("BusStop")
        store_busstop_detail(b, service, geoinfo)
      else
        store_busstop(b, service)
      end
    end
  end

  def fetchInfoAbout(service)
    offset = 0
    url = Base_url + service + "Set"
    resu = ""

    loop do
      response = RestClient.get url, {:params => {'$skip' => offset }, :accept => :json, :AccountKey => Account_key, :UniqueUserID => User_id}
      if response.code != 200
        #log error
      end

      next_elements = JSON.parse response
      resu = [resu, next_elements["d"]].flatten!

      offset += 50
      break if next_elements["d"].size != 50
    end
 
    return resu
  end

  def store_busstop_detail(b, service, geoinfo) 
    bs = BusstopDetail.new
    bs["uid"] = b[service + "ID"].to_i
    bs["busstop_id"] = b["Code"].to_i
    bs["road"] = b["Road"]
    bs["desc"] = b["Description"]
        
    i = geoinfo["features"].index{|x| x["properties"]["BUS_STOP_N"] == b["Code"]} 
    if i != nil 
      bs["long"] = geoinfo["features"][i]["geometry"]["coordinates"][0]
      bs["lat"] = geoinfo["features"][i]["geometry"]["coordinates"][1]
    end
    # update in case already exists? changes of desc for example
    bs.save # response code of save
  end

  def store_busline(b, service)
    bl = Busline.new
    bl["uid"] = !b[service + "ID"].to_s.empty? ? b[service + "ID"].to_i : b[service + "ID"].to_i
    bl["busnumber"] = b["SI_SVC_NUM"]
    bl["direction"] = b["SI_SVC_DIR"].to_i
    bl["type_of_bus"] = b["SI_SVC_CAT"]
    bl["start_code"] = b["SI_BS_CODE_ST"].to_i
    bl["end_code"] = b["SI_BS_CODE_END"].to_i
    bl["freq_am_peak"] = check_for_nil(b["SI_FREQ_AM_PK"])
    bl["freq_am_off"] = check_for_nil(b["SI_FREQ_AM_OF"])
    bl["freq_pm_peak"] = check_for_nil(b["SI_FREQ_PM_PK"])
    bl["freq_pm_off"] = check_for_nil(b["SI_FREQ_PM_OF"])
    bl["loop_code"] = b["SI_LOOP"].to_i
    
    bl.save # response code of save
  end

  def check_for_nil(s) 
    s == nil ? "-" : s.strip
  end

  def store_busstop(b, service)
    br = Busstop.new
    br["uid"] = !b[service + "ID"].to_s.empty? ? b[service + "ID"].to_i : b[service + "ID"].to_i
    br["busnumber"] = !b["SI_SVC_NUM"].to_s.empty? ? b["SI_SVC_NUM"] : b["SR_SVC_NUM"]
    br["direction"] = !b["SI_SVC_DIR"].to_s.empty? ? b["SI_SVC_DIR"].to_i : b["SR_SVC_DIR"].to_i
    br["stop_number"] = b["SR_ROUT_SEQ"].to_i
    br["busstop_id"] = b["SR_BS_CODE"].to_i
        
    br.save # response code of save
  end

end
