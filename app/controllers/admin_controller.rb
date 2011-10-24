class AdminController < ApplicationController
  
  before_filter :authenticate_admin!
  
  def index
    render
  end
  
  def import
    render
  end
  
  def blitz
    render '42'
  end
  
end
