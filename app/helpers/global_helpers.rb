module Merb
  module GlobalHelpers
    def get_types
      ["all", "sbd", "aud", "matrix", "fm", "other"]
    end
    def get_venues
      ["All"] + Venue.all(:order => [:venue_name.asc])
    end
    
    def get_songs
      ["All"] + Song.all(:order => [:song_name.asc])
    end
    
    def get_years
      [["All", "All"], 
       ["2008", "2008"], 
       ["2007","2007"], 
       ["2006", "2006"], 
       ["2005", "2005"], 
       ["2004", "2004"], 
       ["2003", "2003"], 
       ["2002", "2002"]]
    end
    
    def get_search_filters
      [["search_source", "Source"], 
       ["search_lineage", "Lineage"], 
       ["search_taper", "Taper"], 
       ["search_venue_name", "Venue Search"], 
       ["search_year", "Year"], 
       ["search_label", "Label"], 
       ["search_venue_city", "City"], 
       ["search_venue_state", "State"], 
       ["search_type", "Recording Type"]]
    end   
  end
end
