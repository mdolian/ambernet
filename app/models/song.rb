class Song < ActiveRecord::Base

  #t.string              :song_name
  #t.text                :song_lyrics
  #t.string              :written_by
  #t.string              :original_performer
  #t.integer             :instrumental
  
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
