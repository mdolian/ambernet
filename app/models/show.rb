class Show
  include DataMapper::Resource
  
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
  
  def append_segue_or_comma(setlist)
    if setlist.is_segue?
      append = " > "
    else
      append = ", "
    end
    append
  end
  
  def setlist_as_text
    setlists = Setlist.all(:show_id => id)
    set_one = "Set 1: "
    set_two = "Set 2: "
    set_three = "Set 3: "
    encore = "E: "
    setlists.each do |setlist|
      song = Song.get(setlist.song_id)
      
      case setlist.set_id.to_s
        when "1" 
          set_one << song.song_name << append_segue_or_comma(setlist)
        when "2"
          set_two << song.song_name << append_segue_or_comma(setlist)
        when "3"
          set_three << song.song_name << append_segue_or_comma(setlist)
        else
          encore << song.song_name << append_segue_or_comma(setlist)
      end
    end
    set_one = set_one == "Set 1: " ? "" : set_one.chop.chop << "<br>"
    set_two = set_two == "Set 2: " ? "" : set_two.chop.chop << "<br>"
    set_three = set_three == "Set 3: " ? "" : set_three.chop.chop << "<br>"  
    encore = encore == "E: " ? "" : encore.chop.chop << "<br>"  
    set_one << set_two << set_three << encore
  end

end