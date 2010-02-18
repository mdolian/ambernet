class RadioController < ApplicationController
 
  BLOCKSIZE = 16384 
  
  def stream
    s = Shout.new
    s.host = "localhost"
    s.port = 8000
    s.mount = "/example.mp3"
    s.user = "source"
    s.pass = "tuwd7n"
    s.format = Shout::MP3
    
    s.connect

    ['/Users/dolian/projects/ambernet/public/01.mp3','/Users/dolian/projects/ambernet/public/02.mp3'].each do |filename|
	    File.open(filename) do |file|
    		puts "sending data from #{filename}"
    		m = ShoutMetadata.new
    		m.add 'filename', filename
    		s.metadata = m

    		while data = file.read(BLOCKSIZE)
    			s.send data
    			s.sync
    		end
    	end
    end
  
    s.disconnect
    
  end
  
end
