class SongsController < ApplicationController

  before_filter :authenticate_admin!, :except => [:show, :list]
  before_filter :sweep, :only => [:create, :update, :destroy]

  # GET /songs
  def index
    @current_page = (params[:page] || 1).to_i    
    @songs = Song.paginate(:page => @current_page, :order => "song_name ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @songs }
    end
  end

  # GET /songs/1
  def show
    @song = Song.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @song }
    end
  end

  # GET /songs/new
  def new
    @song = Song.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @song }
    end
  end

  # GET /songs/1/edit
  def edit
    @song = Song.find(params[:id])
  end

  # POST /songs
  def create
    @song = Song.new(params[:song])

    respond_to do |format|
      if @song.save
        flash[:notice] = 'Song was successfully created.'
        format.html { redirect_to :action => "index" }
        format.xml  { render :xml => @song, :status => :created, :location => @song }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @song.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /songs/1
  def update
    @song = Song.find(params[:id])

    respond_to do |format|
      if @song.update_attributes(params[:song])
        flash[:notice] = 'Song was successfully updated.'
        format.html { redirect_to :action => "index" }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @song.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /songs/1
  def destroy
    @song = Song.find(params[:id])
    @song.destroy

    respond_to do |format|
      flash[:notice] = "Show was successfully deleted."
      format.html { redirect_to :action => "index" }
      format.xml  { head :ok }
    end
  end
  
  def list
    list = []
    songs = Song.where("song_name LIKE  ?", "%#{params[:q]}%")
    songs.each do |song|
      list << {"label" => song.song_name, "id" => song.id}
    end
    
    respond_to do |format|
      format.json { render :json => list.to_json, :layout => false }
    end
  end
  
private
  def sweep
    expire_fragment :action => [:index, :show]
  end  
    
end
