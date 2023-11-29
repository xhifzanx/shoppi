class Product < ApplicationRecord
	belongs_to :user
	has_many_attached :images
	has_one :category
end
