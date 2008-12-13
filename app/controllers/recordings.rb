require 'recording'

class Recordings < Application

  def index
    render
  end
  
  def show
    @recording = Recording.get(params["id"])
    @recording_tracks = RecordingTrack.all(:recording_id => params["id"])
    render
  end
  
  def new
    render
  end
  
  def create
    shows = Show.all(:date_played.eql => Date.strptime(params["date_played"], "%m/%d/%Y"))
    if shows.empty?
      render "SHOW NOT FOUND"
    else
      @recording = Recording.new(
        :show_id => shows.first.id,
        :label => params["label"],
        :source => params["source"],
        :lineage => params["lineage"],
        :taper => params["taper"],
        :transfered_by => params["transferred_by"],
        :notes => params["notes"],
        :type => params["type"]
      )
      @recording.save
      render :index
    end
  end
end