class Recording
  include DataMapper::Resource
  
  property :id, Serial
  property :notes, String  
  
  has n, :recording_tracks
  has n, :sources
  has n, :wish_lists
  has n, :users, :through => :wish_lists
  belongs_to :show

  def get_recordings_for_show(show_id)
    @recordings = Recording.all(:show_id => show_id)
  end

end
