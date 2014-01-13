class PagesController < ApplicationController
  def index
  end

  def contact
    @message = Message.new
  end
  def send_message
    @message = Message.new(params[:message])
    if @message.valid?
      mail = ContactUsMailer.send_contact_message(@message).deliver
      if ActionMailer::Base.deliveries.last.body != @message.content
        flash[:notice] = 'Message sent successfully'
      else
        flash[:notice] = 'There was a problem sending the message.  Try again later.'
      end
    end
    render :contact
  end

  def about
  end
end
