class RecordingsController < ApplicationController

  before_filter :authenticate_admin!, :except => [:search, :stream, :zip, :show, :index, 
                :zip_link, :generate_mp3, :directory]
  before_filter :sweep, :only => [:create, :update, :destroy]

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
  
  def zip
    recording = Recording.find(params["id"])
    file_list = []
    recording.files(params["filetype"]) do |file|
      file_list << file
    end
    ZipRecording.enqueue(recording.label, params["filetype"], file_list)
    redirect_to :action => "show", :id => params["id"]
  end
  
  def generate_mp3
    GenerateMp3.enqueue(AppConfig.media_dir << Recording.find(params["id"]).label)
    redirect_to :action => "index"
  end
  
  def generate_all_mp3s
    Recording.order("id ASC").each do |recording|
      GenerateMp3.enqueue(AppConfig.media_dir << recording.label)
    end
    render
  end
  
  def zip_link
    recording, filetype, timestamp = Recording.find(params["id"]), params["filetype"], Time.now.strftime("%y%m%d%H%M%S")
    basefile = "/zips/#{recording.label}.#{filetype}.zip"
    if File.exist? "public#{basefile}"
      render :text => "<a href='http://#{request.host}#{basefile}?t=#{timestamp}'> Download </a>"
    elsif File.exist? "public#{basefile}.tmp"
      render :text => "<img src='/images/loading.gif?t=#{timestamp}'>"
    else
      render :text => "<a href='http://#{request.host}/recordings/zip/#{params["id"]}/#{filetype}?t=#{timestamp}'> Zip </a>"
    end
  end
  
  def stream
    recording = Recording.find params["id"]
    stream_file = params["format"] == "pls" ? recording.to_pls : recording.to_m3u
    render :text => stream_file
  end
  
  def directory
    recording, listing = Recording.find(params['id']), "<table width='100%'><tr><td>"
    recording.flac_list.each { |entry| listing << entry << "<br>" }
    listing << "</td><td>" 
    recording.mp3_list.each { |entry| listing << entry << "<br>"}
    listing << "</td></tr></table>"
    render :text => listing
  end
  
private
  def sweep
    expire_fragment :action => [:show]
  end
  
end