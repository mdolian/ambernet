class Song < ActiveRecord::Base
  
  attr_accessible :id, :song_name, :song_lyrics, :written_by, :original_performer, :is_instrumental
  
  has_many :setlists
  has_many :recording_tracks
  has_many :shows, :through => :setlists

  def self.per_page
    100
  end

  scope :song_name_like, lambda { |song_name|
    where("songs.song_name LIKE ?",  "%#{song_name}%")
  }
  
end
