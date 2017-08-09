class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :update, :destroy]
  wrap_parameters :image, include: ['caption']
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_filter :default_format_json

  def index
    @images = Image.all
  end

  def show
  end

  def create
    @image = Image.new(image_params)
    @image.creator_id = current_user.id

    if @image.save
      render :show, status: :created, location: @image
    else
      render json: { errors: @image.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @image.update(image_params)
      head :no_content
    else
      render json: { errors: @image.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @image.destroy

    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_image
      @image = Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def image_params
      params.require(:image).permit(:caption)
    end
end
