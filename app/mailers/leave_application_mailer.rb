class LeaveApplicationMailer < ApplicationMailer
	default from: "admin.hrms@protonshub.com"

  def sample_email(user, leave)
    @user = user
    @leave = leave
    mail(to: @user.email, subject: 'Leave Application Approval Status')
  end
end
