module Merb
  module ShowsHelper

    def get_venues
      ["All"] + Venue.all(:order => [:venue_name.asc])
    end
    
    def get_songs
      ["All"] + Song.all(:order => [:song_name.asc])
    end
    
    def get_years
      ["All", "2008", "2007", "2006", "2005", "2004", "2003", "2002", "2001"]
    end
    
  end
end # Merb