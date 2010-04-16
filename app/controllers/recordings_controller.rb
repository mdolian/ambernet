class RecordingsController < ApplicationController

  before_filter :authenticate_admin!, :except => [:search, :stream, :zip, :show, :index]

  def index
    @current_page = (params[:page] || 1).to_i 
    @recordings = Recording.joins(:show).paginate(:all, :page => @current_page)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @recordings }
    end
  end

  def show
    @recording = Recording.find(params["id"])
    @show = Show.find(@recording.show_id)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @recording }
    end
  end 
 
  def new
    @recording = Recording.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @recording }
    end
  end

  def edit
    @recording = Recording.find(params["id"])
  end

  def create 
    @recording = Recording.new(params[:recording])

    tracking_info = params["discs"] << "["
    for i in (1..params["discs"].to_i)
      tracking_info << params["tracksDisc" << i.to_s] << ","
    end
    tracking_info.chop! << "]"
    params["tracking_info"] = tracking_info    
    
    respond_to do |format|
      if @recording.save
        flash[:notice] = 'Recording was successfully created.'
        format.html { redirect_to :action => "index" }
        format.xml  { render :xml => @recording, :status => :created, :location => @recording }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @recording.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @recording = Recording.find(params["id"])
   
    tracking_info = params["discs"] << "["
    for i in (1..params["discs"].to_i) 
      tracking_info << params["tracksDisc" << i.to_s] << ","
    end
    tracking_info.chop! << "]"
    params["tracking_info"] = tracking_info
     
    respond_to do |format|
      if @recording.update_attributes(params[:recording])
        flash[:notice] = "Recording was successfully updated."
        format.html { redirect_to :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @recording.errors, :status => :unprocessable_entity }
      end
    end    
  end

  def destroy
    @recording = Recording.find(params[:id])
    @recording.destroy

    respond_to do |format|
      flash[:notice] = "Recording was successfully deleted."
      format.html { redirect_to :action => "index" }
      format.xml  { head :ok }
    end
  end
  
  # Rate a show via ajax call
  def rate
    Recording.update(params["id"], {:rating => params["rating"]})
  end

  def zip
    Resque.enqueue(Jobs, params["id"], params["type"]
  end

end