require 'resque'
require 'recording'

class ZipRecording
  @queue = :default

  def self.enqueue(*args)
    Resque.enqueue(self, *args)
  end

  def self.perform(recording, type)
    if !File.exist?("public/ambernet/zips/#{recording.label}.#{recording.type}.zip")
      logger.info("Creating Zip")
      t = File.open("public/ambernet/zips/#{recording.label}.#{recording.type}.zip", "w")
      Zip::ZipOutputStream.open(t.path) do |zos|
        recording.files(type) do |file|
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
