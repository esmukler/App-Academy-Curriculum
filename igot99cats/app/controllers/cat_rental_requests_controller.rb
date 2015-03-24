class CatRentalRequestsController < ApplicationController
  before_action :confirm_cat_owner, only: [:approve, :deny]
  before_action :confirm_logged_in

  def new
    @cat_rental_request = CatRentalRequest.new(cat_id: params[:cat][:id])
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(request_params)
    @cat_rental_request.user_id = current_user.id
    cat = @cat_rental_request.cat

    if @cat_rental_request.save
      flash[:notice] = "Check back later to see if your request to
                        hang with #{cat.name} has been approved"
      redirect_to cat_url(cat)
    else
      render :new
    end
  end


  def approve
    cat_rental_request = CatRentalRequest.find(params[:id])
    cat_rental_request.approve!
    flash[:notice] = "Request Approved!"

    redirect_to cat_url(cat_rental_request.cat)
  end

  def deny
    cat_rental_request = CatRentalRequest.find(params[:id])
    cat_rental_request.deny!
    flash[:notice] = "Request Denied!"

    redirect_to cat_url(cat_rental_request.cat)
  end

  private

    def request_params
      params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id)
    end

end
