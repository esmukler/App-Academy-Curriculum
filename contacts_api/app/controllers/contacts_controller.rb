class ContactsController < ApplicationController

  def index
    # owned_contacts = Contact.find(2)
    user = User.find(params[:user_id])
    owned_contacts = user.contacts
    shared_contacts = user.shared_contacts
    all_contacts = owned_contacts + shared_contacts
    render json: all_contacts
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact
    else
      render json: contact.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    contact = Contact.find(params[:id])
    if contact.update(contact_params)
      render json: contact
    else
      render json: contact.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    render json: Contact.find(params[:id])
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    render json: contact
  end

  private

  def contact_params
    params[:contact].permit(:name, :email, :user_id)
  end

end
