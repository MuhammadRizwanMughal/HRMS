# Preview all emails at http://localhost:3000/rails/mailers/leave_application_mailer
class LeaveApplicationMailerPreview < ActionMailer::Preview
	def sample_mail_preview
    LeaveApplicationMailer.sample_email(User.first)
  end
end
