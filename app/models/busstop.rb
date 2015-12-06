class Busstop < ActiveRecord::Base
      belongs_to :busline, foreign_key: 'busnumber', primary_key: 'busnumber'
      has_one :busstop_detail, foreign_key: 'busstop_id', primary_key: 'busstop_id'

      validates :busnumber, presence: true
      validates :busstop_id, presence: true
      validates :stop_number, presence: true
end
