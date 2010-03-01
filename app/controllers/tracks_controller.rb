class TracksController < ApplicationController

  def edit
    @recording = Recording.find(params["id"])
    @show = Show.find(@recording.show_id)
    setlists = Setlist.all(:conditions => ["show_id = ?", @recording.show_id], :order => "song_order ASC")
    if setlists.size == @recording.total_tracks.to_i
      setlists.each do |setlist|
        track = RecordingTrack.new(:track => setlist.song_order, 
                                    :recording_id => @recording.id, 
                                    :song_id => setlist.song_id)
        track.save
      end
      flash.now[:notice] = "We were able to automatically import this one!"
      render :import
    else
      1.upto(@recording.total_tracks.to_i) do |i|
        song_id = i < setlists.size ? setlists[i-1].song_id : 0
        tracks = RecordingTrack.all(:conditions => {:track => i,
                                                    :recording_id => @recording.id,
                                                    :song_id => song_id})
        if tracks.empty?                               
          track = RecordingTrack.new(:track => i,
                                     :recording_id => @recording.id,
                                     :song_id => song_id)
          track.save
        end
      end
      @recording_tracks = RecordingTrack.all(:conditions => ["recording_id = ?", @recording.id], :order => "track ASC")
      flash.now[:error] = "Total Tracks = #{@recording.total_tracks} ::::: Setlist Size = #{setlists.size}"
      render :edit
    end
  end
  
  def list
    list = []
    tracks = RecordingTrack.all(:conditions => ["recording_id=? AND track=?", params["recording_id"], params["track"]])
    tracks.each do |track|
      list << {"label" => track.song_name, "id" => track.song_id}
    end

    respond_to do |format|
      format.json { render :json => list.to_json, :layout => false }
    end
  end  
  
  def add
    "not done yet"
  end
end
