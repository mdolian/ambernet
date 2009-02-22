class Show
  include DataMapper::Resource
  
  is_paginated
  
  property :id, Serial
  property :date_played, Date
  property :show_notes, Text
  property :audio_available, Boolean
  property :date_created, DateTime
  property :date_updated, DateTime
  property :updated_by, String
  property :is_active, Boolean
  
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
  
  def setlist_as_json
    setlist_json = []
    setlists.each do |setlist|
      song = Song.get(setlist.song_id)
      setlist_json << {"set_id" => setlist.set_id, "song_order" => setlist.song_order, "song_name" => song.song_name, "segue" => setlist.song_suffix}
    end    
    setlist_json
  end
  
end