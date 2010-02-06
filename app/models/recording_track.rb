class RecordingTrack < ActiveRecord::Base
  
  #t.string        :s3_bucket
  #t.string        :track
  #t.integer       :recording_id, :null => false

  belongs_to :recording
  has_and_belongs_to_many :setlists

end
