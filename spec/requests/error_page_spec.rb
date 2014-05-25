# encoding: UTF-8
require 'spec_helper'

feature 'Error pages' do
  context 'with the default exceptions app', if: !ENV["CUSTOM_EXCEPTIONS_APP"] do
    scenario 'Internal server error due to RuntimeError' do
      visit '/users/1'

      page.status_code.should == 500
      page.body.should have_content "Error page"
      page.body.should have_content "Something went wrong."
    end

    scenario 'Not found due to CustomException' do
      visit '/users'

      page.status_code.should == 404
      page.body.should have_content "Error page"
      page.body.should have_content "Page not found."
    end

    scenario 'Not found due to ActinoController::RoutingError' do
      visit '/doesnt_exist'

      page.status_code.should == 404
      page.body.should have_content "Error page"
      page.body.should have_content "Page not found."
    end
  end

  context "With a custom exception app", if: ENV["CUSTOM_EXCEPTIONS_APP"] do
    scenario 'Internal server error due to RuntimeError' do
      visit '/users/1'

      page.status_code.should == 500
      page.body.should have_content "Custom error page"
    end
  end
end
