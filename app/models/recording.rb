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
  property :directory, String
  
  # totalDiscs[totalDisc1Tracks, TotalDisc2Tracks, TotalDisc3Tracks...]
  property :tracking_info, String
  property :shnid, String
  property :directory, String
    
  belongs_to :show  
  has n, :recording_tracks
#  has n, :users, :through => Resource

  # Returns the total number of discs
  def discs
    tracking_info[0].chr
  end

  # Returns the total number of tracks for a given disc number
  def track(disc_num)
    tracks.split(',')[disc_num-1]
  end
  
  # Returns a string containing all tracks for each disc delimited by a comma
  def tracks
    tracking_info[2..-1].chop!
  end
    
  # Returns total number of tracks in recording  
  def total_tracks
    total = 0
    tracks.each(',') { |track| total += track.to_i }
    total.to_s
  end
  
  # Returns a string containing a pls file
  def to_pls
    pls = "[playlist]\nNumberOfEntries=" << total_tracks << "\n\n"
    disc_count = 0
    for disc_count in (1..discs.to_i)
      for track_count in (1..track(disc_count).to_i)
        pls << "File#{total_tracks}=/ambernet/#{directory}/pg#{show.year_as_label}-d0#{disc_count}-t#{track_count}.mp3\n"
        pls << "Title#{total_tracks}=TBD\n"
        pls << "Length#{total_tracks}=-1\n\n"
      end
    end
    pls
  end

end