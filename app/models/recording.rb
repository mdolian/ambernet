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
  
  def download_extension(type)
    case type
      when "lossless": lossless_extension
      when "mp3": "mp3"
      else "ERROR"
    end
  end

  # Returns the total number of discs
  def total_discs
    tracking_info[0].chr
  end

  # Returns the total number of tracks for a given disc number
  def tracks_for_disc(disc_num)
    tracks = tracking_info[2..-1].chop!.split(',')[disc_num-1].to_i
    if tracks.to_i < 10
      "0" + tracks.to_s
    else
      tracks.to_s
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
    total_count = 0
    tracks do |track|
      total_count = total_count + 1
      pls << "File#{total_count}=http://ambernetonline.net/ambernet/#{label}/#{track}.mp3\n"
      pls << "Title#{total_count}=TBD\n"
      pls << "Length#{total_count}=-1\n\n"
    end
    pls
  end

  # Returns a string containing a m3u file  
  def to_m3u
    m3u = "#EXTM3\n"
    tracks do |track|
      m3u << "#EXTINF:-1,TBD\n"
      m3u << "http://ambernetonline.net/ambernet/#{label}/#{track}.mp3\n"
    end
    m3u
  end
  
  def tracks
    disc_count = 0
    total_count = 0
    for disc_count in (1..total_discs.to_i)
      for track_count in "01"..tracks_for_disc(disc_count) do     
        total_count = total_count + 1
        yield "pgroove#{show.date_as_label}d#{disc_count}t#{track_count}"
      end
    end
  end
   
  def files(type)
    tracks do |track|
      yield File.open("/media/PG_Archive/ambernet/#{label}/#{track}.#{download_extension(type)}") 
    end
  end
end