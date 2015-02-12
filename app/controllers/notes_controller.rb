class NotesController < ApplicationController

  def new
    render :new
  end

  def create
    @note = Note.new(track_id: params[:track_id], user_id: current_user.id)
    @note = Note.create(note_params)
    @note.user_id = current_user.id
    @note.save
    redirect_to track_url(@note.track)
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

    def note_params
      params.require(:note).permit(:body, :track_id)
    end

end
