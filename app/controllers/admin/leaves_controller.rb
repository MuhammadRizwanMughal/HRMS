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
      if @leave.leave_type == 'Casual Leave'
        @user.user_leave_distribution.c_leave = @user.user_leave_distribution.c_leave - @leave.sdate.business_days_until(@leave.edate)
        @user.user_leave_distribution.save
        @leave.status = 'Approved'
        @leave.save
        @user.save
        # flash[:notice] = "Casual leave application of #{@user.fname + ' ' + @user.lname} for #{@leave.sdate.business_days_until(@leave.edate) + 1} days from #{@sdate} to #{@edate} was approved successfull !!"  
      elsif @leave.leave_type == 'Priviledge Leave'
        binding.pry
        @user.user_leave_distribution.p_leave = @user.user_leave_distribution.p_leave - @leave.sdate.business_days_until(@leave.edate)
        @user.user_leave_distribution.save
        @leave.status = 'Approved'
        @leave.save
        @user.save
      else
        @user.user_leave_distribution.s_leave = @user.user_leave_distribution.s_leave - @leave.sdate.business_days_until(@leave.edate)
        @user.user_leave_distribution.save
        @leave.status = 'Approved'
        @leave.save
        @user.save
      end
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
    #   if @leave.sdate == @leave.edate
    #     @user.leave_left = @user.leave_left - 1
    #     @user.leaves_taken = @user.leaves_taken + 1
    #   else
    #     @user.leave_left  = @user.leave_left + (-1) - (@leave.sdate.business_days_until(@leave.edate))
    #     @user.leaves_taken = @user.leaves_taken + 1 + (@leave.sdate.business_days_until(@leave.edate))
    #   end
    #     @leave.status = 'Approved'
    #     @leave.save
    #     @user.save
