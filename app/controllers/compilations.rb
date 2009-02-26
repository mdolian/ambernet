class Compilations < Application

  before :ensure_authenticated, :only => [:admin, :new, :create, :edit, :delete, :update]

  def index
    @compilations = Compilation.all
    render
  end
  
  def show
    @compilation = Compilation.all(:id => params["id"])
    render
  end
  
  def new
    render "not completed"
  end
  
  def create
    render "not completed"
  end
  
end
