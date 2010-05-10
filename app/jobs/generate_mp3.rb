require 'resque'

class GenerateMp3 < DefaultJob

  def self.perform(directory)
    begin
      results = %x[/data/ambernet/current/bin/audio_conversion/shn2mp3 --target #{directory} #{directory}]
    rescue => msg
      puts "MP3 conversion failed with: #{results} - #{msg}"
    end
  end
  
end