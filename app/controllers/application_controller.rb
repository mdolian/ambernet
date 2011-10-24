class ApplicationController < ActionController::Base

  def blitz
    render :text => '42'
  end

end
