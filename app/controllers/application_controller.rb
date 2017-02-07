class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  
  before_action :cors_headers

  def cors
    response.headers['Access-Control-Allow-Origin'] = request.origin
    response.headers['Access-Control-Allow-Headers'] = request.headers['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']
    response.headers['Access-Control-Allow-Methods'] = "GET,POST,PATCH,DELETE,OPTIONS,PUT";
  end

  private

  def cors_headers
    response.headers['Access-Control-Allow-Origin'] = request.origin
    response.headers['Access-Control-Allow-Headers'] = request.headers['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']
    response.headers['Access-Control-Allow-Methods'] = "GET,POST,PATCH,DELETE,OPTIONS,PUT";
  end
end
