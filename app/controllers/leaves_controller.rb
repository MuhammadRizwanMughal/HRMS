class LeavesController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def new
  	@user = User.find(params[ :user_id ])
  	@leave = @user.leaves.new
  end

  def create
  	@user = User.find(params[ :user_id ])
    @leave = leave_params
    @sdate = @leave[ :sdate ].to_date 
    @edate = @leave[ :edate ].to_date
    if @user.user_leave_distribution.present?
      if @sdate > @edate
        redirect_to new_user_leave_path
        flash[:notice] = "Start date can't be after End date."
      else
        if leave_params[ :leave_type ] == 'Casual Leave'
          if @sdate.business_days_until(@edate) < @user.user_leave_distribution.c_leave
            @leave = @user.leaves.create(leave_params)
            redirect_to user_path(@user)
            flash[:notice] = "Casual leave application of #{@sdate.business_days_until(@edate) + 1} days from #{@sdate} to #{@edate} successfull. Currently in pending state for approval !!"  
          else
            flash[:notice] = "Casual leave of #{@user.user_leave_distribution.c_leave} days left."
            redirect_to new_user_leave_path
          end
        elsif leave_params[ :leave_type ] == 'Priviledge Leave'
          if @sdate.business_days_until(@edate) < @user.user_leave_distribution.p_leave
            @leave = @user.leaves.create(leave_params)
            redirect_to user_path(@user)
            flash[:notice] = "Priviledge leave application of #{@sdate.business_days_until(@edate) + 1} days from #{@sdate} to #{@edate} successfull. Currently in pending state for approval !!"  
          else
            flash[:notice] = "Priviledge leave of #{@user.user_leave_distribution.p_leave} days left."
            redirect_to new_user_leave_path
          end
        else 
          if @sdate.business_days_until(@edate) < @user.user_leave_distribution.s_leave
            @leave = @user.leaves.create(leave_params)
            redirect_to user_path(@user)
            flash[:notice] = "Sick/Medical leave application of #{@sdate.business_days_until(@edate) + 1} days from #{@sdate} to #{@edate} successfull. Currently in pending state for approval !!" 
          else
            flash[:notice] = "Sick/Medical leave of #{@user.user_leave_distribution.s_leave} days left."
            redirect_to new_user_leave_path
          end
        end  
      end
    else  
      redirect_to  new_user_leave_path
      flash[:notice] = "There seems to be some error. Contact Mr.Admin"  
    end
  end	

  def show
    @user = User.find(params[:user_id])
    @leaves = @user.leaves
  end

  def destroy
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


