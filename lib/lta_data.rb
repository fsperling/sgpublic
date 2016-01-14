require 'json'

class LtaData
  Busrouter_data_path = 'data/busrouter-bus-stops.json'

  def check_data 
    find_busstops_without_coords
    find_busstops_without_details
  end

  def find_busstops_without_coords
    fixed = 0
    busrouter_data = JSON.parse(File.read(Busrouter_data_path))

    stops = BusstopDetail.without_coords.to_a
    Rails.logger.info "Found #{stops.count} stops without coords"

    stops.each do |stop|
      stop_id = stop.busstop_id.to_s.rjust(5, '0')
      if busrouter_data.key?(stop_id)
        Rails.logger.info "Found coords for stop: #{stop_id}"
        if busrouter_data[stop_id]['name'].eql?(stop.desc)
          coords = busrouter_data[stop_id]['coords'].split(',')
          stop.long = coords[0]
          stop.lat = coords[1]
          stop.save!
          fixed+=1
        else
          Rails.logger.info "Busstop name mismatch: #{busrouter_data[stop_id]['name']} and #{stop.desc}"
        end
      end
    end

    Rails.logger.info "Found coords for #{fixed} stops"
    BusstopDetail.delete_without_coords
  end

  def find_busstops_without_details

  end
end
