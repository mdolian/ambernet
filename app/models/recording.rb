class Recording
  include DataMapper::Resource
  
  is_paginated
  
  property :id, Serial
  property :label, String
  property :source, Text
  property :lineage, Text
  property :taper, String
  property :transfered_by, String
  property :notes, Text
  property :type, String
  property :filetype, String
  
  # totalDiscs[totalDisc1Tracks, TotalDisc2Tracks, TotalDisc3Tracks...]
  property :tracking_info, String
  property :shnid, String
    
  belongs_to :show  
  has n, :recording_tracks
#  has n, :users, :through => Resource

  def lossless_extension
    case filetype
      when "flac16": "flac"
      when "flac24": "flac"
      when "shnf":   "shn"
      else           "ERROR"
    end
  end

  # Returns the total number of discs
  def discs
    tracking_info[0].chr
  end

  # Returns the total number of tracks for a given disc number
  def tracks(disc_num)
    tracks = tracking_info[2..-1].chop!.split(',')[disc_num-1].to_i
    puts tracks.to_s
    if tracks.to_i < 9
      "0" + tracks.to_s
    else
      tracks
    end
  end
  
  # Returns total number of tracks in recording  
  def total_tracks
    total = 0
    tracking_info[2..-1].chop!.each(',') { |track| total += track.to_i }
    total.to_s
  end
  
  # Returns a string containing a pls file
  def to_pls
    pls = "[playlist]\nNumberOfEntries=" << total_tracks << "\n\n"
    disc_count = 0
    total_count = 0
    for disc_count in (1..discs.to_i)
      for track_count in "01"..tracks(disc_count) do      
        total_count = total_count + 1
        pls << "File#{total_count}=http://ambernet.kicks-ass.net/ambernet/#{label}/pgroove#{show.date_as_label}d#{disc_count}t#{track_count}.mp3\n"
        pls << "Title#{total_count}=TBD\n"
        pls << "Length#{total_count}=-1\n\n"
      end
    end
    pls
  end
  
  def track_list
    trackName = Array.new
    for i in 1..discs.to_i do
      for j in "01"..tracks(i) do
        trackName << "pgroove" + show.date_as_label + "d" + i.to_s + "t" + j.to_s
      end
    end
  end

end