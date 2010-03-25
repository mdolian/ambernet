require 'will_paginate'

class Show < ActiveRecord::Base
    
  #t.date        :date_played
  #t.text        :show_notes
  #t.integer     :venue_id, :null => false
  
  has_many :setlists
  has_many :recordings
  has_many :songs, :through => :setlists
  belongs_to :venue

  scope :by_venue_city, lambda { |venue_city|
    joins(:venue).
    where("venues.venue_city LIKE ?",  "%#{venue_city}%")
  }  

  scope :by_venue_state, lambda { |venue_state|
    joins(:venue).
    where("venues.venue_city LIKE ?",  "%#{venue_state}%")
  }

  scope :by_venue_name, lambda { |venue_name|
    joins(:venue).
    where("venues.venue_name LIKE ?",  "%#{venue_name}%")
  }    

  scope :by_date, lambda { |*dates|
    where("shows.date_played BETWEEN ? AND ?", dates[0], dates[1])
  }
  
  scope :by_song, lambda { |song_name|
    joins(:setlists, :songs).
    where("songs.song_name LIKE ?", "%#{song_name}%")
    group("shows.id")
  }
  
  scope :by_label, lambda { |label| 
    joins(:recordings) & Recording.by_label(label)
  }

  scope :by_source, lambda { |source|
    joins(:recordings) & Recording.by_source(source)
  }
  
  scope :by_lineage, lambda { |lineage|
    joins(:recordings) & Recording.by_lineage(lineage)
  }

  scope :by_taper, lambda { |taper|
    joins(:recordings) & Recording.by_taper(taper)
  }
    
  scope :by_shnid, lambda { |shnid|
    joins(:recordings) & Recording.by_shnid(shnid)
  }

  scope :by_recording_type, lambda { |recording_type|
    joins(:recordings) & Recording.by_recording_type(recording_type)
  }
  
  # I forget why this was needed
  def date_as_label
    date_played.to_s
  end
  
  # the show label
  def label
    date_played.to_s << " - " << venue.venue_name << " " << venue.venue_city << ", " << venue.venue_state
  end
  
  # get an array of setlist objects for show
  def setlists
    Setlist.all(:conditions => ["show_id  = ? ", id], :order => "set_id ASC, song_order ASC")
  end

  # get the total sets in the show
  def total_sets
    Setlist.maximum(:set_id, :conditions => ["set_id != '9' AND show_id = ?", id])
  end
  
  # for will_paginate
  def self.per_page
    25
  end
  
  def recording_count
    Recording.joins(:show).where("recordings.show_id = ?", id).count
  end 

  def self.search(asset_params, page, per_page)
    main = order("date_played desc").group("shows.id").joins(:setlists, :songs, :venue).group("shows.date_played")
    asset_params.each do |key, value|
      main = main.send(:"by_#{key.to_s}", value)  if main.respond_to?(:"by_#{key.to_s}") && !(value == '' || value == 'all' || value == 'Enter Name Here')
    end if asset_params
    main.paginate(:all, :page => page, :per_page => per_page)
  end
  
  # untested
  def setlist
    for i in 1..9 do
      setlist << ", " if i == 1
      setlist << setlist_as_text(i) if setlist_as_text(i) != ""
    end
    setlist
  end
  
  # returns the setlist given a set_id, encore=9
  def setlist_as_text(set_id)
    setlist_text = ""
    setlists.each do |setlist|
      song = Song.find(setlist.song_id)      
      setlist_text << song.song_name << setlist.song_suffix if (set_id == setlist.set_id)
    end
    setlist_text
  end
  
#  define_index do
#    indexes recording.date_played, :sortable => true
#    indexes venue.venue_name, :sortable => true
#    indexes venue.venue_city, :sortable => true
#    indexes venue.venue_state, :sortable => true        
#    indexes setlist.song.song_name

#    has recording.date_played, venue.venue_name, venue.venue_city, venue.venue_state
#  end  
  
end