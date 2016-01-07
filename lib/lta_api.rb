require 'rest-client'
require 'json'

class LtaApi
  Base_url = "http://datamall.mytransport.sg/ltaodataservice.svc/"
  Account_key = ENV['DATAMALL_ACCOUNT_KEY']
  User_id = ENV['DATAMALL_USER_ID']
  Busstop_geoinfo_path = 'data/BusStop_Oct2015/busstops.json'

  def getDataFor(service) 
    businfo = fetch_info_about(service)

    geoinfo = ''
    if service.include?('BusStop')
      geoinfo = JSON.parse(File.read(Busstop_geoinfo_path))
    end

    businfo.each do |b|
      if service.include?('Info')
        store_busline(b, service)
      elsif service.include?('BusStop')
        store_busstop_detail(b, service, geoinfo)
      else
        store_busstop(b, service)
      end
    end
  end

  def fetch_info_about(service)
    url = Base_url + service + 'Set'
    offset = 0
    result = ''

    loop do
      response = RestClient.get url, params: { '$skip' => offset }, accept: :json, AccountKey: Account_key, UniqueUserID: User_id
      if response.code != 200
        # log error
      end

      next_elements = JSON.parse response
      result = [result, next_elements['d']].flatten!

      offset += 50
      break if next_elements['d'].size != 50
    end

    result
  end

  def store_busstop_detail(b, service, geoinfo)
    bs = BusstopDetail.new
    bs['uid'] = b[service + 'ID'].to_i
    bs['busstop_id'] = b['Code'].to_i
    bs['road'] = b['Road']
    bs['desc'] = b['Description']

    i = geoinfo['features'].index{ |x| x['properties']['BUS_STOP_N'] == b['Code'] }
    if !i.nil?
      bs['long'] = geoinfo['features'][i]['geometry']['coordinates'][0]
      bs['lat'] = geoinfo['features'][i]['geometry']['coordinates'][1]
    end
    # update in case already exists? changes of desc for example
    bs.save # response code of save
  end

  def store_busline(b, service)
    bl = Busline.new
    bl['uid'] = !b[service + 'ID'].to_s.empty? ? b[service + 'ID'].to_i : b[service + 'ID'].to_i
    bl['busnumber'] = b['SI_SVC_NUM']
    bl['direction'] = b['SI_SVC_DIR'].to_i
    bl['type_of_bus'] = b['SI_SVC_CAT']
    bl['start_code'] = b['SI_BS_CODE_ST'].to_i
    bl['end_code'] = b['SI_BS_CODE_END'].to_i
    bl['freq_am_peak'] = sanitize_bus_freq(b['SI_FREQ_AM_PK'])
    bl['freq_am_off'] = sanitize_bus_freq(b['SI_FREQ_AM_OF'])
    bl['freq_pm_peak'] = sanitize_bus_freq(b['SI_FREQ_PM_PK'])
    bl['freq_pm_off'] = sanitize_bus_freq(b['SI_FREQ_PM_OF'])
    bl['loop_code'] = b['SI_LOOP'].to_i

    bl.save # response code of save
  end

  def sanitize_bus_freq(s)
    s.nil? ? '-' : s.strip
  end

  def store_busstop(b, service)
    bs = Busstop.new
    bs['uid'] = !b[service + 'ID'].to_s.empty? ? b[service + 'ID'].to_i : b[service + 'ID'].to_i
    bs['busnumber'] = !b['SI_SVC_NUM'].to_s.empty? ? b['SI_SVC_NUM'] : b['SR_SVC_NUM']
    bs['direction'] = !b['SI_SVC_DIR'].to_s.empty? ? b['SI_SVC_DIR'].to_i : b['SR_SVC_DIR'].to_i
    bs['stop_number'] = b['SR_ROUT_SEQ'].to_i
    bs['busstop_id'] = b['SR_BS_CODE'].to_i

    bs.save # response code of save
  end
end
