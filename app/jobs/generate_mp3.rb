require 'resque'

class GenerateMp3 < DefaultJob

  def self.perform(label)
    exec "/data/ambernet/current/bin/flac2mp3 #{label}"
  end
  
end