class TracksController < ApplicationController

  def edit
    @recording = Recording.find(params["id"])
    setlists = Setlist.all(:conditions => ["show_id = ?", @recording.show_id], :order => "song_order ASC")
    if setlists.size == @recording.total_tracks.to_i
      setlists.each do |setlist|
        track = RecordingTrack.new(:track => setlist.song_order, 
                                    :recording_id => @recording.id, 
                                    :song_id_start => setlist.song_id,
                                    :song_id_end => setlist.song_id)
        track.save
      end
      flash.now[:notice] = "We were able to automatically import this one!"
      render :import
    else
      1.upto(@recording.total_tracks.to_i) do |i|
        song_id = i < setlists.size ? setlists[i].song_id : 0
        tracks = RecordingTrack.all(:conditions => {:track => i,
                                                    :recording_id => @recording.id,
                                                    :song_id_start => song_id,
                                                    :song_id_end => song_id})
        if tracks.empty?                               
          track = RecordingTrack.new(:track => i,
                                     :recording_id => @recording.id,
                                     :song_id_start => song_id,
                                     :song_id_end => song_id)
          track.save
        end
      end
      @recording_tracks = RecordingTrack.all(:conditions => ["recording_id = ?", @recording.id], :order => "track ASC")
      flash.now[:error] = "Total Tracks = #{@recording.total_tracks} ::::: Setlist Size = #{setlists.size}"
      render :edit
    end
  end
  
end
