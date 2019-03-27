class Admin::LeavesController < ApplicationController
  before_action :authenticate_user!
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
      if @leave.leave_type == 'Casual Leave'
        if @leave.sdate == @leave.edate
          @user.user_leave_distribution.c_leave = @user.user_leave_distribution.c_leave - 1
        else
          @user.user_leave_distribution.c_leave = @user.user_leave_distribution.c_leave - (@leave.sdate.business_days_until(@leave.edate) + 1)
        end
      elsif @leave.leave_type == 'Priviledge Leave'
        if @leave.sdate == @leave.edate
          @user.user_leave_distribution.p_leave = @user.user_leave_distribution.p_leave - 1
        else
          @user.user_leave_distribution.p_leave = @user.user_leave_distribution.p_leave - (@leave.sdate.business_days_until(@leave.edate) + 1)
        end
      else
        if @leave.sdate == @leave.edate
          @user.user_leave_distribution.s_leave = @user.user_leave_distribution.s_leave - 1
        else          
          @user.user_leave_distribution.s_leave = @user.user_leave_distribution.s_leave - (@leave.sdate.business_days_until(@leave.edate) + 1)
        end
      end
        notification = Notification.create(receiver: @user, actor: current_user, action: "Application for Leave of #{@leave.sdate.business_days_until(@leave.edate) + 1} days from #{@leave.sdate} to #{@leave.edate} was successfull approved.", notifiable: @leave)
        notification.save
        @user.user_leave_distribution.save
        @leave.status = 'Approved'
        @leave.save
        @user.save
    when 'Denied'
      notification = Notification.create(receiver: @user, actor: current_user, action: "Application for Leave of #{@leave.sdate.business_days_until(@leave.edate) + 1} days from #{@leave.sdate} to #{@leave.edate} was denied", notifiable: @leave)
      notification.save
      @leave.status = 'Denied'
      @leave.save
      @user.save
    end 
      LeaveApplicationMailer.sample_email(@user, @leave).deliver_later
  end

  private
  def leave_params
  	params.require(:leave).permit(:type, :sdate, :edate, :description)
  end
end