class AdminController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    render
  end
  
end
