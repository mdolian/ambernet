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
  
  def setlist_as_text
    setlists = Setlist.all(:show_id => id)
    formatted_setlist = "Set 1: "
    setlists.each do |setlist|
      song = Song.get(setlist.song_id)
      formatted_setlist = formatted_setlist + song.song_name
      if setlist.is_segue?
        formatted_setlist = formatted_setlist + " > "
      else
        formatted_setlist = formatted_setlist + ", "
      end
    end
    formatted_setlist
  end

end