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
    is_segue? ? " > " : song_order == Setlist.max(:song_order, :show_id => show_id, :set_id => set_id) ? "" : ", "
  end
    
  def first
    id
  end
  
  def total_sets
    Setlist.max(:set_id, :set_id.not => "9", :show_id => show_id)
  end
      
end