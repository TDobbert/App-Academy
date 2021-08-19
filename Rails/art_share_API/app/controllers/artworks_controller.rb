# app/controllers/artworks_controller.rb
class ArtworksController < ApplicationController
  def index
    render json: Artwork.all
  end

  def create
    artwork = Artwork.new(artwork_params)

    if artwork.save
      render json: artwork
    else
      render json: artwork.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    render json: Artwork.find(params[:id])
  end

  private

  def artwork_params
    params.require(:title).permit(:image_url)
  end
end
