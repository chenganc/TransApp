class BusStop < ApplicationRecord
	has_many :reviews
	has_many :microposts
end
