class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  class Forbidden < ActionController::ActionControllerError; end
  class IPAddressRejected < ActionController::ActionControllerError; end
  
  include ErrorHandlers if Rails.env.production?

end