class Recording
  include DataMapper::Resource
  
  is_paginated
  
  property :id, Serial
  property :label, String
  property :source, String
  property :lineage, String
  property :taper, String
  property :transfered_by, String
  property :notes, String
  property :type, String
  property :shnid, String
  property :directory, String
    
  belongs_to :show  
  has n, :recording_tracks
  has n, :recording_discs
#  has n, :users, :through => Resource

  def to_pls
    pls = "[playlist]\nNumberOfEntries="
    track_pls = ""
    total_tracks = 0 
    for disc_count in (1..recording_discs.count)
      total_tracks += recording_discs[disc_count-1].tracks.to_i
      for track_count in (1..recording_discs[disc_count-1].tracks)
        track_pls << "File1=/ambernet/#{directory}/pg#{show.year_as_label}-d0#{disc_count}-t#{track_count}.mp3\n"
        track_pls << "Title1=TBD\n"
        track_pls << "Length1=-1\n\n"
      end
    end
    pls << total_tracks << "\n\n" << track_pls
  end

end
