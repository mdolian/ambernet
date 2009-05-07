class Amberland < Application

  def index
    render :layout => "user"
  end
  
  def info
    render :layout => false
  end      
end
