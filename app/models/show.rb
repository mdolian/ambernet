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
    Setlist.find(:show_id => id, :order => [:set_id.asc, :song_order.asc])
  end
  
  def total_sets
    Show.maxiumum(Show.setlists.set_id, :show_id => id)
  end
  
  def self.per_page
    2
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