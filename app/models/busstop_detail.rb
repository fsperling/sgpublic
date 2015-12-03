class BusstopDetail < ActiveRecord::Base
      acts_as_mappable :default_units => :kms,
                       :lng_column_name => :long
      belongs_to :busstop, primary_key: 'busstop_id', foreign_key: 'busstation_id'

      validates :busstop_id, presence: true, uniqueness: true
      validates :road, presence: true

      # would be better, there are still some without coords, geocode with help of other API?
      #validates :lat, presence: true
      #validates :long, presence: true
end
