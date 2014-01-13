require 'spec_helper'

describe 'Contact Page' do
  let(:user) {create(:user)}
  def fill_out_contact_form(name='Tommy', email='tommy16@ancient.com', subject='Just Testing',
      content = "Shall clasp a rare and radiant maiden whom the angels named Lenore,\nQuoth the raven, 'Nevermore'")
    login(user)
    visit '/contact'
    fill_in 'message_name', with: name
    fill_in 'message_email', with: email
    fill_in 'message_subject', with: subject
    fill_in 'message_content', with: content
    click_button 'Send Message'
  end
  it 'should send contact email' do
    fill_out_contact_form
    ActionMailer::Base.deliveries.empty?.should be_false
  end
  it 'should throw a validation error if there is an invalid field' do
    fill_out_contact_form('')
    ActionMailer.Base::deliveries.empty?.should be_true
  end
end