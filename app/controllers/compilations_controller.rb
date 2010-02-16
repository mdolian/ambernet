class CompilationsController < ApplicationController

  #before :ensure_authenticated, :only => [:admin, :new, :create, :edit, :delete, :update]

  def index
    @compilations = Compilation.all
    render
  end
  
  def show
    @compilation = Compilation.find(params["id"])
    render
  end
  
  def new
    render "TO-DO"
  end
  
  def create
    render "TO-DO"
  end
  
  def update
    render "TO-DO"
  end
  
  def destroy
    render "TO-DO"
  end  
  
  def edit
    render "TO-DO"
  end  

end
