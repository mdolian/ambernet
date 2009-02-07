class Tracks < Application
  #before :ensure_authenticated

  params_accessible :post => [:id, :recording_id, :track, :setlist]

  def edit
    recording = Recording.get(params["id"])
    @setlists = Setlist.all(:show_id => recording.show_id)
    @tracks = RecordingTrack.all(:recording_id => params["id"])
    render
  end
  
  def update
    render "NOT DONE YET"
  end
  
  def add
    track = RecordingTrack.new(
      :track => params["track"],
      :recording_id => params["recording_id"]
    )
    track.save
    params["setlist"].each do |setlist|
      track_setlist = RecordingTrackSetlist.new(
        :recording_track_id => track.id,
        :setlist_id => setlist
      )
      track_setlist.save
    end
    render :edit
  end
end
