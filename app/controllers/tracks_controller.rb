class TracksController < ApplicationController

  before_filter :authenticate_admin!

  def edit
    @recording = Recording.find(params["id"])
    @show = Show.find(@recording.show_id)
    setlists = Setlist.where("show_id = ?", @recording.show_id).order("song_order ASC")
    tracks = RecordingTrack.where("recording_id = ?", @recording.id)
    if setlists.size == @recording.total_tracks.to_i && tracks.empty?
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
        song_id = i < setlists.size+1 ? setlists[i-1].song_id : 0
        tracks = RecordingTrack.where("track = ? AND recording_id = ? AND song_id = ?", i, @recording.id, song_id)
        if tracks.empty?                               
          track = RecordingTrack.new(:track => i,
                                     :recording_id => @recording.id,
                                     :song_id => song_id)
          track.save
        end
      end
      @recording_tracks = RecordingTrack.where("recording_id = ?", @recording.id).order("track ASC")
      flash.now[:error] = "Total Tracks :: #{@recording.total_tracks} | Setlist Length :: #{setlists.size}"
      render :edit
    end
  end
  
  def list
    list = []
    tracks = RecordingTrack.where("recording_id = ? AND track = ?", params["recording_id"], params["track"])
    tracks.each do |track|
      list << {"label" => track.song_name, "id" => track.song_id}
    end

    respond_to do |format|
      format.json { render :json => list.to_json, :layout => false }
    end
  end  
  
  def save
    tracks = RecordingTrack.where("recording_id = ? ", params["recording_id"])
    tracks.each do |track|
      track.destroy
    end
    for i in 1..params["total_tracks"].to_i do
      song_list = params["as_values_track_#{i}"].split(",")
      logger.info "BLAH: #{song_list.size}"
      logger.info "#{song_list.last}"
      song_list.delete_at(0)
      song_list.each do |song_id|
        logger.info "SONG ID: #{song_id}"
        track = RecordingTrack.new(:track => i,
                                   :recording_id => params["recording_id"],
                                   :song_id => song_id)
        track.save
      end
    end
    redirect_to "/tracks/edit/#{params["recording_id"]}"
  end
end
