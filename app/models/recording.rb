require 'will_paginate'

class Recording < ActiveRecord::Base
  
  attr_accessible :id, :label, :source, :lineage, :taper, :transfered_by, :notes, 
                 :recording_type, :tracking_indo, :shnid, :filetype, :show_id
    
  has_many :recording_tracks
  belongs_to :show
  has_one :venue, :through => :show  

  scope :by_recording_type, lambda { |recording_type|
    where("recordings.recording_type LIKE ?", "%#{recording_type}%")
  }

  scope :by_label, lambda { |label|
    where("recordings.label LIKE ?",  "%#{label}%")
  }
  
  scope :by_source, lambda { |source|
    where("recordings.source LIKE ?",  "%#{source}%")
  }
  
  scope :by_lineage, lambda { |lineage|
    where("recordings.lineage LIKE ?",  "%#{lineage}%")
  }

  scope :by_taper, lambda { |taper|
    where("recordings.taper LIKE ?",  "%#{taper}%")
  }
    
  scope :by_shnid, lambda { |shnid|
    where("recordings.shnid = ?", shnid)
  }
  
  scope :by_date, lambda { |*dates|
    joins(:show) & Show.by_date(*dates)
  }
  
  scope :by_venue_id, lambda { |venue_id|
    joins(:show) & Show.by_venue_id(venue_id)
  }
  
  scope :by_venues, lambda { |venue_ids|
    joins(:show, :venue) & Show.by_venues(venue_ids)
  }
  
  scope :by_songs, lambda { |song_ids|
      joins(:show) & Show.by_songs(*song_ids)
  }
  
  scope :by_song_id, lambda { |song_id|
    joins(:show) & Show.by_song_id(song_id)
  }
  
  scope :by_show_id, lambda { |show_ids|
    joins(:show).
    where("recordings.show_id IN (?)", show_ids)
  }
  
  def extension
    case filetype
      when "flac16" then "flac"
      when "flac24" then "flac"
      when "shnf"   then "shn"
      when "mp3f"   then "mp3"
      else               "ERROR"
    end
  end
  
  def download_extension(type)
    case type
      when "lossless" then extension
      when "mp3"      then "mp3"
      else                 "ERROR"
    end
  end

  # Returns the total number of discs
  def total_discs
    tracking_info[0].chr
  end

  # Returns the total number of tracks for a given disc number
  def tracks_for_disc(disc_num)
    tracks = tracking_info[2..-1].chop!.split(',')[disc_num-1].to_i
    if tracks < 10
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
    tracks do |track, count|
      pls << "File#{count}=http://ambernetonline.net/ambernet/#{label}/#{track}.mp3\n"
      pls << "Title#{count}=TBD\n"
      pls << "Length#{count}=-1\n\n"
    end
    logger.info pls
    pls
  end

  # Returns a string containing a m3u file  
  def to_m3u
    m3u = "#EXTM3\n"
    disc_count = 0
    total_count = 0
    tracks do |track, count|
      m3u << "#EXTINF:-1,TBD\n"
      m3u << "http://ambernetonline.net/ambernet/#{label}/#{track}.mp3\n"
    end
    m3u
  end
  
  def tracks
    disc_count, total_count = 0, 0
    for disc_count in (1..total_discs.to_i)
      for track_count in "01"..tracks_for_disc(disc_count) do
        total_count = total_count + 1
        yield "pgroove#{show.date_as_label}d#{disc_count}t#{track_count}", total_count
      end
    end
  end
   
  def files(type)
    tracks do |track, total_count|
      yield "/media/PG_Archive/ambernet/#{label}/#{track}.#{download_extension(type)}" 
    end
  end

  def self.per_page
    25
  end
  
  def flac_list
    begin
      Dir.chdir("/media/PG_Archive/ambernet/#{label}/")
      Dir.glob("*.flac")
    rescue
      ["No FLACs exist"]
    end
  end
  
  def mp3_list
    begin
      Dir.chdir("/media/PG_Archive/ambernet/#{label}/#{label}.mp3f/")
      Dir.glob("*.mp3")
    rescue
      ["No MP3s exist"]
    end
  end
  
  def mp3s_generated?
    flac_list.size == mp3_list.size
  end

#  define_index do
#    indexes :date_played, :sortable => true
#    indexes venue.venue_name, :sortable => true
#    indexes venue.venue_city, :sortable => true
#    indexes venue.venue_state, :sortable => true
#    indexes :label, :sortable => true
#    indexes :source, :sortable => true
#    indexes :lineage, :sortable => true
#    indexes :taper, :sortable => true
#    indexes :type, :sortable => true
#    indexes :shnid, :sortable => true       
#    indexes setlist.song.song_name

#    has date_played, type, label, venue.venue_name, venue.venue_city, venue.venue_state
#  end  

end