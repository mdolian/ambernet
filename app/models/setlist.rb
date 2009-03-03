class Setlist
  include DataMapper::Resource
  
  property :id, Serial
  property :set_id, Integer
  property :song_order, Integer
  property :song_comments, Text
  property :is_segue, Boolean
  
  belongs_to :show
  belongs_to :song
  has n, :recording_tracks, :through => Resource
  
  def last
    song.song_name
  end

  def song_suffix
    if is_segue? then " > " else ", " end
  end
    
  def first
    id
  end
      
end