class ProductConfigurationsController < ApplicationController
	def index
	end

	def generate_category
		return if params["category"].blank?
		Category.create(name: params["category"]["name"])
		redirect_to product_configurations_path
	end
end
