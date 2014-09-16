# encoding: UTF-8
require 'spec_helper'

feature 'Error json response', if: !ENV["CUSTOM_EXCEPTIONS_APP"], type: :request do
  def json_response
    JSON.parse(response.body)
  end

  def get(path)
    super(path, nil, "CONTENT_TYPE" => "application/json", "HTTP_ACCEPT" => "application/json")
  end

  scenario 'returns 422 json due to ActionController:InvalidAuthenticityToken but without its template' do
    get '/users/new'

    expect(response.status).to eq(422)
    expect(json_response['message']).to eq("Something went wrong")
  end

  scenario 'returns 500 json due to RuntimeError' do
    get '/users/1.json'

    expect(response.status).to eq(500)
    expect(json_response['message']).to eq("Something went wrong")
  end

  scenario 'returns 404 json due to CustomException' do
    get '/users.json'

    expect(response.status).to eq(404)
    expect(json_response['message']).to eq("Page not found")
  end

  scenario 'returns 404 json due to ActinoController::RoutingError' do
    get '/doesnt_exist.json'

    expect(response.status).to eq(404)
    expect(json_response['message']).to eq("Page not found")
  end
end
