class TracksController < ApplicationController

  def new
    @album = Album.find(params[:album_id])
    @track = Track.new(album_id: @album.id)
    render :new
  end

  def create
    @album = Album.find(params[:track][:album_id])
    @track = Track.new(track_params)

    if @track.save
      redirect_to track_url(@track)
    else
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])

    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      render :edit
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to album_url(@track.album)
  end

  private

    def track_params
      params.require(:track).permit(:name, :lyrics, :album_id, :status)
    end

end
