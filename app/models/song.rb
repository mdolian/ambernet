class Song
  include DataMapper::Resource
  
  property :id, Serial
  property :song_name, String
  property :song_lyrics, Text
  property :written_by, String
  property :original_performer, String
  property :guitar_tabs, Text
  property :guitar_tabs_credit, String
  property :audio_file, String
  property :is_instrumental, Boolean
  property :date_created, DateTime
  property :date_updated, DateTime
  property :updated_by, Integer
  property :is_active, Boolean
  
  has n, :setlists

  def first
    id
  end
  
  def last
    song_name
  end
  
end
