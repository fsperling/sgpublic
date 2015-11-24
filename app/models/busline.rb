class Busline < ActiveRecord::Base
      has_many :busstops, foreign_key: 'busnumber', primary_key: 'busnumber'

      validates :busnumber, presence: true
      validates :start_code, presence: true
      validates :end_code, presence: true
end
