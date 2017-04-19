class Review < ActiveRecord::Base
	belongs_to :user
	belongs_to :bus_stop
	validates :comment, presence: true, length: { maximum: 140 }

end
