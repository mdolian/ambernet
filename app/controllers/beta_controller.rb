class BetaController < ApplicationController

  before_filter :authenticate_user!

  def index
    render
  end
  
  def contact
    render
  end
  
  def bug
    render
  end
  
end
