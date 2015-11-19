class BusstopDetail < ActiveRecord::Base
      belongs_to :busstop, primary_key: 'busstop_id', foreign_key: 'busstation_id'

      validates :busstop_id, presence: true, uniqueness: true
      validates :road, presence: true
end
