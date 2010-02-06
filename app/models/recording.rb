require 'will_paginate'

class Recording < ActiveRecord::Base
  
  #t.string        :label
  #t.text          :source
  #t.text          :lineage
  #t.string        :taper
  #t.string        :transfered_by
  #t.text          :notes
  #t.string        :type
  #t.string        :tracking_info - totalDiscs[totalDisc1Tracks, TotalDisc2Tracks, TotalDisc3Tracks...]
  #t.string        :shnid
  #t.string        :filetype      
  #t.integer       :show_id, :null => false
    
  belongs_to :show  
  has_many :recording_tracks

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
    tracks do |track|
      pls << "File#{total_count}=http://ambernetonline.net/ambernet/#{label}/pgroove#{show.date_as_label}d#{disc_count}t#{track_count}.mp3\n"
      pls << "Title#{total_count}=TBD\n"
      pls << "Length#{total_count}=-1\n\n"
    end
  end

  # Returns a string containing a m3u file  
  def to_m3u
    m3u = "#EXTM3\n"
    disc_count = 0
    total_count = 0
    tracks do |track|
      m3u << "#EXTINF:-1,TBD\n"
      m3u << "http://ambernetonline.net/ambernet/#{label}/#{track}.mp3\n"
    end
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