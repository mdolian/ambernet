class Exceptions < Merb::Controller
  
  # handle NotFound exceptions (404)
  def not_found
    render :format => :html, :layout => "admin"
  end

  # handle NotAcceptable exceptions (406)
  def not_acceptable
    render :format => :html, :layout => "admin"
  end
  
  def unauthenticated
    render :format => :html, :layout => "admin"
  end  

end