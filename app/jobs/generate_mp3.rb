require 'resque'

class GenerateMp3 < DefaultJob

  def self.perform(label)
    begin
      results = %x[/data/ambernet/current/bin/flac2mp3 #{label}]
    rescue => msg
      puts "MP3 conversion failed with: #{results} - #{msg}"
    end
  end
  
end