require 'will_paginate'

class Recording < ActiveRecord::Base
  
  attr_accessible :id, :label, :source, :lineage, :taper, :transfered_by, :notes, 
                 :recording_type, :tracking_indo, :shnid, :filetype, :show_id

  has_many :have_lists
  has_many :recording_likes
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
  
  scope :featured, joins(:show).where("s3_available = 1")
  
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
    tracks do |track, track_name, count|
      pls << "File#{count}=http://#{AppConfig.media_link}#{label}/#{label.gsub(/flac16|mp3f|flac24|shnf/, 'mp3f')}/#{track}.mp3\n"
      pls << "Title#{count}=#{track_name}\n"
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
    tracks do |track, track_name, count|
      m3u << "#EXTINF:-1,#{track_name}\n"
      m3u << "http://#{AppConfig.media_link}#{label}/#{label.gsub(/flac16|mp3f|flac24|shnf/, 'mp3f')}/#{track}.mp3\n"
    end
    m3u
  end
  
  def tracks
    disc_count, total_count = 0, 0
    for disc_count in (1..total_discs.to_i)
      for track_count in "01"..tracks_for_disc(disc_count) do
        total_count = total_count + 1
        tracks = RecordingTrack.where('recording_id = ? AND track = ?', id, total_count)
        song_list = ""
        tracks.each do |track|
          song = Song.find track.song_id
          song_list = song_list + song.song_name + ", "
          song_list.chop!.chop!
        end
        yield "pgroove#{show.date_as_label}d#{disc_count}t#{track_count}", song_list == "" ?  "pgroove#{show.date_as_label}d#{disc_count}t#{track_count}" : song_list, total_count
      end
    end
  end
   
  def files(type)
    tracks do |track, track_name, total_count|
      if type == "mp3"
        yield "#{AppConfig.media_link}#{label}/#{label.gsub(/flac16|mp3f|flac24|shnf/, "mp3f")}/#{track}.#{download_extension(type)}" 
      else  
        yield "#{AppConfig.media_link}#{label}/#{track}.#{download_extension(type)}" 
      end
    end
  end

  def self.per_page
    25
  end
  
  def flac_list
    begin         
      Dir.glob "#{flac_dir}/*.#{extension}"
    rescue
      ["Empty"]
    end
  end
  
  def mp3_list
    begin   
      Dir.glob "#{mp3_dir}/*.mp3"         
    rescue
      ["Empty"]
    end
  end
  
  def mp3s_generated?
    logger.info "ID: #{id} - #{flac_list.size.to_s}:#{mp3_list.size.to_s}"    
    flac_list.size == mp3_list.size
  end
  
  def mp3_dir
    flac_dir << "/" << label.gsub(/flac16|mp3f|flac24|shnf/, "mp3f")
  end
  
  def flac_dir
    "#{AppConfig.offline_media_dir}#{label}"
  end
  
  define_index do
    indexes show.date_played, :sortable => true
    indexes venue.venue_name, :sortable => true
    indexes venue.venue_city, :sortable => true
    indexes venue.venue_state, :sortable => true
    indexes :label, :sortable => true
    indexes :source, :sortable => true
    indexes :lineage, :sortable => true
    indexes :taper, :sortable => true
    indexes :recording_type, :sortable => true
    indexes :shnid, :sortable => true       
    #indexes setlist.song.song_name
  end  

end