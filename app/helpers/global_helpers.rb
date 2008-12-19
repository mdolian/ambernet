module Merb
  module GlobalHelpers
    def get_types
      ["sbd", "aud", "matrix", "fm", "other"]
    end
    def get_venues
      ["All"] + Venue.all(:order => [:venue_name.asc])
    end
    
    def get_songs
      ["All"] + Song.all(:order => [:song_name.asc])
    end
    
    def get_years
      ["All", "2008", "2007", "2006", "2005", "2004", "2003", "2002", "2001"]
    end
    
    def get_search_filters
      ["search_source", "search_lineage", "search_taper", "search_venue_name", "search_year", "search_label", "search_venue_city", "search_venue_state", "search_type"]
    end   
  end
end
