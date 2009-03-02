class Song
  include DataMapper::Resource
  
  property :id, Serial
  property :song_name, String, :length => 100
  property :song_lyrics, Text
  property :written_by, String
  property :original_performer, String
  property :is_instrumental, Boolean
  
  has n, :setlists

  def first
    id
  end
  
  def last
    song_name
  end
  
end