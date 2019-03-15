class Admin::LeavesController < ApplicationController
  def index
    @user = User.find(params[:user_id]) 
    @leaves = @user.leaves
  end

  def create
  	@user = User.find(params[:user_id])
   	@leave = @user.leaves.find_by_id(:id)
  end	

  def show
    @user = User.find(params[:user_id])
    if @user.leaves.present?
      @leaves = @user.leaves
      @leave = Leave.find(params[:id])
    end
  end

  
  def user_leave_approval_decision
    @user = User.find(params[:user_id])
    @leaves = @user.leaves
    @leave = Leave.find params[:leave_id]
    case params["leave_approval_decision"]
    when 'Approve'
      @user.leave_left  = @user.leave_left + (-1) - (@leave[:edate].to_date - @leave[:sdate].to_date)
      @user.leaves_taken = @user.leaves_taken + 1 + (@leave[:edate].to_date - @leave[:sdate].to_date)
      @leave.status = 'Approved'
      @leave.save
      @user.save
    when 'Denied'
      @leave.status = 'Denied'
      @leave.save
      @user.save
    end
  end

  private
  def leave_params
  	params.require(:leave).permit(:type, :sdate, :edate, :description)
  end
end
