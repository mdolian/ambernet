class Song < ActiveRecord::Base

  #t.string              :song_name
  #t.text                :song_lyrics
  #t.string              :written_by
  #t.string              :original_performer
  #t.boolean             :is_instrumental
  
  has_many :setlists

  def self.per_page
    100
  end
  
end
