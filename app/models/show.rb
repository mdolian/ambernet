require 'will_paginate'
require 'will_paginate/finders/data_mapper'
require 'will_paginate/view_helpers/action_view'

class Show
  include DataMapper::Resource
    
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
  
  def date_as_label
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