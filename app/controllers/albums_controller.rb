class AlbumsController < ApplicationController
  before_action :require_login

  def new
    @band = Band.find(params[:band_id])
    @album = Album.new(band_id: @band.id)
    render :new
  end

  def create
    @band = Band.find(params[:album][:band_id])
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      render :edit
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to band_url(@album.band)
  end

  private

    def album_params
      params.require(:album).permit(:name, :setting, :band_id)
    end


end
