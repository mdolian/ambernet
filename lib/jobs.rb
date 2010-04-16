require 'resque'

module Jobs
  module Zip
    @queue = :default

    def self.perform(id, type)
      @recording = Recording.find(id)
      if !File.exist?("public/ambernet/zips/#{@recording.label}.#{type}.zip")
        t = File.open("public/ambernet/zips/#{@recording.label}.#{type}.zip", "w")
        Zip::ZipOutputStream.open(t.path) do |zos|
          @recording.files(type) do |file|
            zos.put_next_entry(File.basename(file.path))
            zos.print IO.read(file.path)
            logger.debug "File added to zip: #{file.path}"    
          end
        end
        logger.debug "Temp Zip Path: /zips/#{File.basename(t.path)}"
        t.close
      end
    end
  end
end