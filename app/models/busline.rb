class Busline < ActiveRecord::Base
      has_many :busstops, foreign_key: 'busnumber', primary_key: 'busnumber'

end
