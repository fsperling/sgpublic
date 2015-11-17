class Busstop < ActiveRecord::Base
      validates :code, presence: true, uniqueness: true
      validates :road, presence: true
end
