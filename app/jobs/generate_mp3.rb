require 'resque'

class GenerateMp3 < DefaultJob

  def self.perform(label)
    @result = %x[bin/flac2mp3 #\{label\}]
  end
  
end