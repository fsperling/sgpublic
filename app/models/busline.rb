class Busline < ActiveRecord::Base
  has_many :busstops, foreign_key: 'busnumber', primary_key: 'busnumber'

  validates :busnumber, presence: true
  validates :start_code, presence: true
  validates :end_code, presence: true

  def get_coords
    line_coords = []
    self.busstops.map(&:busstop_detail).each do |stop|

      unless stop == nil
        if stop.long == nil || stop.lat == nil
          #log error: no coords
        else
          line_coords += [[stop.long, stop.lat]]
        end
      end
    end
    line_coords
  end

end


#@features += [{type: 'Feature', properties: {name: stop.road}, geometry: {type: 'Point', coordinates: [stop.long, stop.lat]} }]
