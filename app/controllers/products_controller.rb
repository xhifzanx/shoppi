class ProductsController < ApplicationController
	before_action :set_product, only: %i[edit update show]
	skip_before_action :verify_authenticity_token, only: [:create]
	def index
	end
	def new
		@product = Product.new
	end
	def create
		@product = Product.create(product_params.merge(user_id: current_user.id))
		dropzone_images = params.dig(:product, :images).first&.values
		dropzone_images&.map do |dropzone_image|

		uploaded_file = ActionDispatch::Http::UploadedFile.new(
		  tempfile: dropzone_image.tempfile,
		  filename: File.basename(dropzone_image.tempfile),
		  type: dropzone_image.content_type
		)
		@product.images.attach(io: uploaded_file.tempfile, filename: uploaded_file.original_filename)
		end
		@product.save
		redirect_to products_path
	end
	def edit
	end
	def update
	end
	def show
		# @image_urls = @product.images.map { |image| rails_blob_path(image, only_path: true) }
	end
	private
	def product_params
    params.require(:product).permit(:name, :price, :description)
	end
	def set_product
		@product = Product.find(params[:id])
	end
end
