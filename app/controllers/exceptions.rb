class Exceptions < Merb::Controller
  
  # handle NotFound exceptions (404)
  def not_found
    render :format => :html
  end

  # handle NotAcceptable exceptions (406)
  def not_acceptable
    render :format => :html
  end
  
  def unauthenticated
    render :format => :html
  end 
  
  if %w( staging production ).include?(Merb.env)
    def standard_error
      HoptoadNotifier.notify_hoptoad(request, session)
      render
    end
  end   

end