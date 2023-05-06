# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  http_basic_authenticate_with name: "q", password: "q"
end
