class CompilationsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show]

  def index
    @current_page = (params[:page] || 1).to_i 
    @compilations = Compilation.paginate(:page => @current_page) 

    respond_to do |format|
      format.html
      format.xml  { render :xml => @compilations }
    end
  end

  def show
    @compilation = Compilation.find(params["id"])
    respond_to do |format|
      format.html
      format.xml  { render :xml => @compilation }
    end
  end 
 
  def new
    @compilation = Compilation.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @compilation }
    end
  end

  def edit
    @compilation = Compilation.find(params["id"])
  end

  def create 
    @compilation = Compilation.new(params[:compilation])

    respond_to do |format|
      if @compilation.save
        flash[:notice] = "Compilation was successfully created."
        format.html { redirect_to :action => "index" }
        format.xml  { render :xml => @compilation, :status => :created, :location => @compilation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @compilation.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @compilation = Compilation.find(params["id"])
  
    respond_to do |format|
      if @compilation.update_attributes(params[:compilation])
        flash[:notice] = "Compilation was successfully updated."
        format.html { redirect_to :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @compilation.errors, :status => :unprocessable_entity }
      end
    end    
  end

  def destroy
    @compilation = Compilation.find(params[:id])
    @compilation.destroy

    respond_to do |format|
      flash[:notice] = "Compilation was successfully updated."
      format.html { redirect_to :action => "index" }
      format.xml  { head :ok }
    end
  end

end
