require 'will_paginate'

class Show < ActiveRecord::Base
    
  #t.date        :date_played
  #t.text        :show_notes
  #t.integer     :venue_id, :null => false
  
  has_many :setlists
  has_many :recordings
  belongs_to :venue
  
  def first
    id
  end
  
  def last
    date_played
  end
  
  def date_as_label
    date_played.to_s
  end
  
  def label
    date_played.to_s << " - " << venue.venue_name << " " << venue.venue_city << ", " << venue.venue_state
  end
  
  def setlists
    Setlist.all(:conditions => ["show_id  = ? ", id], :order => "set_id ASC, song_order ASC")
  end

  def total_sets
    Setlist.maximum(:set_id, :conditions => ["set_id != '9' AND show_id = ?", id])
  end
  
  def self.per_page
    2
  end
  
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