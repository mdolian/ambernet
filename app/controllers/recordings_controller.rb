class RecordingsController < ApplicationController

  #before_filter :authenticate_user!, :except => [:search, :stream, :zip, :show]

  def index
    @current_page = (params[:page] || 1).to_i 
    @recordings = Recording.paginate(:joins => {:show => :venue}, :page => @current_page) 

    respond_to do |format|
      format.html
      format.xml  { render :xml => @recordings }
    end
  end

  def show
    @recording = Recording.find(params["id"])
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
  
  # TO-DO - convert to Rails
  def zip
    only_provides :zip
    @recording = Recording.find(params["id"])
    if !File.exist?("public/ambernet/zips/#{@recording.label}.#{params['type']}.zip")
      t = File.open("public/ambernet/zips/#{@recording.label}.#{params['type']}.zip", "w")
      Zip::ZipOutputStream.open(t.path) do |zos|
        @recording.files(params["type"]) do |file|
          zos.put_next_entry(File.basename(file.path))
          zos.print IO.read(file.path)
          logger.debug "File added to zip: #{file.path}"    
        end
      end
      logger.debug "Temp Zip Path: /zips/#{File.basename(t.path)}"
      t.close   
    end
    
    #headers['Content-Disposition'] = "attachment; filename = #{@recording.label}.#{params['type']}.zip"
    #headers['Content-Type'] = "application/zip"
    
    #respond_to do |format|
    #  format.zip
    #end
    
    # TO-DO - This will be replaced by resque
    # Need to implement, this was a Merb function
    #nginx_send_file "/ambernet/zips/#{@recording.label}.#{params['type']}.zip" 
  end

end