class ThingsController < ApplicationController
  before_action :set_thing, only: [:show, :update, :destroy]
  wrap_parameters :thing, include: ['name', 'description', 'notes']
  before_action :authenticate_user!, only: [:index, :create, :update, :destroy]
  before_filter :default_format_json

  def index
    @things = Thing.all
  end

  def show
  end

  def create
    @thing = Thing.new(thing_params)

    if @thing.save
      render :show, status: :created, location: @thing
    else
      render json: { errors: @thing.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @thing.update(thing_params)
      head :no_content
    else
      render json: { errors: @thing.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @thing.destroy

    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_thing
      @thing = Thing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def thing_params
      params.require(:thing).permit(:name, :description, :notes)
    end
end
