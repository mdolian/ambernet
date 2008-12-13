class Tracks < Application

  # ...and remember, everything returned from an action
  # goes to the client...
  def edit
    recording = Recording.get(params["id"])
    @setlists = Setlist.all(:show_id => recording.show_id)
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
    render "saved"
  end
end
