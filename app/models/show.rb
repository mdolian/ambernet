class Show
  include DataMapper::Resource
  
  is_paginated
  
  property :id, Serial
  property :date_played, Date
  property :show_notes, Text
  
  has n, :setlists
  has n, :recordings
  belongs_to :venue
  
  def first
    id
  end
  
  def last
    date_played
  end
  
  def year_as_label
    date_played.to_s
  end
  
  def label
    date_played.to_s << " - " << venue.venue_name << " " << venue.venue_city << ", " << venue.venue_state
  end
  
  def setlists
    Setlist.all(:show_id => id, :order => [:set_id.asc, :song_order.asc])
  end
  
  def total_sets
    Show.max(Show.setlists.set_id, :show_id => id)
  end
  
end