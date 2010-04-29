require 'resque'

class GenerateMp3 < DefaultJob

  def self.perform(label)
    @results = %x[/data/ambernet/current/bin/flac2mp3 #\{label\}]
    logger.info "RESULTS :::::: #{@results}"
  end
  
end