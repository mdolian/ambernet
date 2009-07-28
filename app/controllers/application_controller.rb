class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  # TO-DO - This is turned off because the Rails form helper, form_for has not been implemented yet.  
  #         Without that helper method, invalid authenticity token errors are thrown when submitting forms
  #protect_from_forgery # See ActionController::RequestForgeryProtection for details

  filter_parameter_logging :password
end
