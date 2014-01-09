require 'spec_helper'

def loadLog
  login(user)
  visit log_user_path(user)
  page.find('#from_date').set(Date.today - 1.month)
  page.execute_script %Q{$('.from-date input').change()}  #manually fire change event
end
describe 'log page' do
  let(:user) { create(:user_with_history)}
   it 'shows date range picker' do
     login(user)
     visit log_user_path(user)
     Date.parse(page.find_field('from_date').value).should == Date.today - 1.week
     Date.parse(page.find_field('to_date').value).should == Date.today
   end
  it 'displays workout log div', js:true do
    loadLog
    page.should have_selector('#calendar')
  end
  it 'displays completed workout log', js:true do
    a = user.completed_workouts.first.name
    b = user.completed_workouts.last.name
    a_date = user.completed_workouts.first.date
    loadLog
    page.should have_content("#{a} -- #{a_date.strftime('%m/%d/%Y')}")
    page.should have_content("#{b} -- #{(a_date - 4.days).strftime('%m/%d/%Y')}")
  end
end