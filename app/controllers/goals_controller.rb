class GoalsController < ApplicationController

  def new
    render :new
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      redirect_to user_url(@goal.user)
    else
      redirect_to user_url(@goal.user)
    end
  end

  def edit
    @goal = Goal.find(params[:id])
    render :edit
  end

  def update
    @goal = Goal.find(params[:id])

    if @goal.update(goal_params)
      redirect_to user_url(@goal.user)
    else
      render :edit
    end
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_url(@goal.user)
  end


  private

    def goal_params
      params.require(:goal).permit(:name, :status, :availability, :user_id)
    end

end
