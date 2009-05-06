class Amberland < Application

  def index
    render
  end
  
  def info
    render :layout => false
  end      
end
