class PagesController < ApplicationController
  def index
  end

  def contact
    @message = Message.new
  end
  def send_message
    @message = Message.new(params[:message])
    mailer = ContactUsMailer.send_contact_message(params).deliver
    if @message.valid?
      ContactUsMailer.send_contact_message(@message).deliver
      flash[:notice] = 'Message sent successfully'
    else
      flash[:notice] = 'There was a problem sending the message.  Try again later.'
    end
    render :contact
  end

  def about
  end
end
