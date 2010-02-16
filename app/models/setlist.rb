class Setlist < ActiveRecord::Base
  
  #t.integer       :set_id
  #t.integer       :song_order
  #t.text          :song_comments
  #t.boolean       :is_segue
  #t.integer       :show_id, :null => false
  #t.integer       :song_id, :null => false
  
  has_one :show
  belongs_to :song
#  has_and_belongs_to_many :recording_tracks
  
  def last
    song.song_name
  end

  def song_suffix
    is_segue? ? " > " : song_order == Setlist.maximum(:song_order, :show_id => show_id, :set_id => set_id) ? "" : ", "
  end
    
  def first
    id
  end
  
  def total_sets
    Setlist.maximum(:set_id, :set_id.not => "9", :show_id => show_id)
  end
      
end