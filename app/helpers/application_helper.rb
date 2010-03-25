module ApplicationHelper

  def get_recording_types
    [["Select a Recording Type", "all"], 
     ["sbd", "sbd"],
     ["aud", "aud"],
     ["matrix", "matrix"],
     ["fm", "fm"],
     ["other", "other"]]
  end
  
  def get_states
     [["All", "All"],
      [ "Alabama", "AL" ],
      [ "Alaska", "AK" ],
      [ "Arizona", "AZ" ],
      [ "Arkansas", "AR" ],
      [ "California", "CA" ],
      [ "Colorado", "CO" ],
      [ "Connecticut", "CT" ],
      [ "Delaware", "DE" ],
      [ "Florida", "FL" ],
      [ "Georgia", "GA" ],
      [ "Hawaii", "HI" ],
      [ "Idaho", "ID" ],
      [ "Illinois", "IL" ],
      [ "Indiana", "IN" ],
      [ "Iowa", "IA" ],
      [ "Kansas", "KS" ],
      [ "Kentucky", "KY" ],
      [ "Louisiana", "LA" ],
      [ "Maine", "ME" ],
      [ "Maryland", "MD" ],
      [ "Massachusetts", "MA" ],
      [ "Michigan", "MI" ],
      [ "Minnesota", "MN" ],
      [ "Mississippi", "MS" ],
      [ "Missouri", "MO" ],
      [ "Montana", "MT" ],
      [ "Nebraska", "NE" ],
      [ "Nevada", "NV" ],
      [ "New Hampshire", "NH" ],
      [ "New Jersey", "NJ" ],
      [ "New Mexico", "NM" ],
      [ "New York", "NY" ],
      [ "North Carolina", "NC" ],
      [ "North Dakota", "ND" ],
      [ "Ohio", "OH" ],
      [ "Oklahoma", "OK" ],
      [ "Oregon", "OR" ],
      [ "Pennsylvania", "PA" ],
      [ "Rhode Island", "RI" ],
      [ "South Carolina", "SC" ],
      [ "South Dakota", "SD" ],
      [ "Tennessee", "TN" ],
      [ "Texas", "TX" ],
      [ "Utah", "UT" ],
      [ "Vermont", "VT" ],
      [ "Virginia", "VA" ],
      [ "Washington", "WA" ],
      [ "West Virginia", "WV" ],
      [ "Wisconsin", "WI" ],
      [ "Wyoming", "WY" ]]
  end  
  
  def get_filetypes
    [["Select a Recording Type", "All"],
      ["flac16", "flac16"],
      ["shnf", "shnf"],
      ["flac24", "flac24"],
      ["mp3f", "mp3f"]]
  end    
  
  def get_venues
    ["All"] + Venue.all(:order => "venue_name ASC").collect {|v| [ v.venue_name, v.id ]}
  end
  
  def get_songs
    ["All"] + Song.all(:order => "song_name ASC").collect {|s| [ s.song_name, s.id ]}
  end
  
  def get_years
    [["Select a Year", "All"], 
     ["2010", "2010"],    
     ["2009", "2009"],
     ["2008", "2008"], 
     ["2007", "2007"], 
     ["2006", "2006"], 
     ["2005", "2005"], 
     ["2004", "2004"], 
     ["2003", "2003"], 
     ["2002", "2002"],
     ["2001", "2001"]]
  end

end
