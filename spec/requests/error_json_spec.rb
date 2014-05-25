# encoding: UTF-8
require 'spec_helper'

feature 'Error json responses', if: !ENV["CUSTOM_EXCEPTIONS_APP"] do
  def json_response
    JSON.parse(response.body)
  end

  def get(path)
    super(path, nil, "CONTENT_TYPE" => "application/json", "HTTP_ACCEPT" => "application/json")
  end

  scenario 'Internal server error due to RuntimeError' do
    get '/users/1.json'

    response.status.should == 500
    json_response['message'].should == "Something went wrong"
  end

  scenario 'Not found due to CustomException' do
    get '/users.json'

    response.status.should == 404
    json_response['message'].should == "Page not found"
  end

  scenario 'Not found due to ActinoController::RoutingError' do
    get '/doesnt_exist.json'

    response.status.should == 404
    json_response['message'].should == "Page not found"
  end
end
