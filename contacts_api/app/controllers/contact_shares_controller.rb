class ContactSharesController < ApplicationController

  def create
    cs = ContactShare.new(contact_share_params)
    if cs.save
      render json: cs
    else
      render json: cs.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    cs = ContactShare.find(params[:id])
    cs.destroy
    render json: cs
  end

  private

    def contact_share_params
      params[:contact_share].permit(:contact_id, :user_id)
    end
end
