class Setlist < ActiveRecord::Base

  attr_accessible :id, :set_id, :song_order, :song_comments, :is_segue, :show_id, :song_id
  
  belongs_to :show
  belongs_to :song
  
  def song_suffix
    is_segue? ? " > " : song_order == Setlist.maximum(:song_order, :conditions => ["show_id = ? AND set_id = ?", show_id, set_id]) ? "" : ", "
  end
  
  def song_name
    Song.find(:song_id).song_name
  end
        
end