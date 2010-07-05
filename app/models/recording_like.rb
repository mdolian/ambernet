class RecordingLike < ActiveRecord::Base
  
  #t.integer       :recording_id, :null => false
  #t.integer       :user_id, :null => false
  
  belongs_to :recording
  belongs_to :user
  
end