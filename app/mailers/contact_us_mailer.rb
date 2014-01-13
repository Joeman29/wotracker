class ContactUsMailer < ActionMailer::Base
  default from: "admin@WOtracker.com"
  ADMIN_EMAIL= 'yosef29@gmail.com'
  def send_contact_message(params)
    @user =  params[:name]
    @content= params[:content]
    mail(to:ADMIN_EMAIL, from:params[:email], subject: params[:subject])
  end
end
