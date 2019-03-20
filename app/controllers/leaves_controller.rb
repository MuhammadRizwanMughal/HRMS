class LeavesController < ApplicationController
  def index
  end
  
  def new
  	@user = User.find(params[:user_id])
  	@leave = @user.leaves.new
  end

  def create
  	@user = User.find(params[:user_id])
    @leave = leave_params
    @sdate = @leave[:sdate].to_date
    @edate = @leave[:edate].to_date
    @sdate.business_days_until(@edate)
    if @sdate.business_days_until(@edate) != 0 && @user.leave_left == 1 
      flash[:notice] = "Leave of only #{@user.leave_left} days left."
      redirect_to new_user_leave_path
    elsif @sdate.business_days_until(@edate) > @user.leave_left && @leave[:edate] > @leave[:sdate]
      flash[:notice] = "Leave of only #{@user.leave_left} days left."
      redirect_to new_user_leave_path
    elsif @user.leave_left <= 0
      flash[:notice] = "No leave days left"
      redirect_to new_user_leave_path
    else
      @leave = @user.leaves.create(leave_params)   
      flash[:notice] = "Leave Application Success (LeaveID: #{@leave.id}). Currently in pending approval!!!"
      redirect_to user_path(@user)
    end
  end	

  def show
    @user = User.find(params[:user_id])
    @leaves = @user.leaves
  end

  def destroy
    binding.pry
    @user = User.find params[:user_id]
    @leave = Leave.find params[:id]
    @leave.destroy
    redirect_to user_path(@user)
  end

  private
  def leave_params
  	params.require(:leave).permit(:leave_type, :sdate, :edate, :description)
  end
end
