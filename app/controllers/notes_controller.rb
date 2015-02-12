class NotesController < ApplicationController
  before_action :cant_delete_others_notes, only: :delete

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
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to track_url(@note.track)
  end

  private

    def note_params
      params.require(:note).permit(:body, :track_id)
    end

    def cant_delete_others_notes
      render text: "403 FORBIDDEN" unless current_user.id == @note.user_id
    end

end
