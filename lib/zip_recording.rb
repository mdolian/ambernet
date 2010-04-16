require 'resque'

class ZipRecording
  @queue = :default

  def self.enqueue(*args)
    Resque.enqueue(self, *args)
  end

  def self.perform(id, type, label, files)
    if !File.exist?("public/ambernet/zips/#{label}.#{type}.zip")
      logger.info("Creating Zip")
      t = File.open("public/ambernet/zips/#{label}.#{type}.zip", "w")
      Zip::ZipOutputStream.open(t.path) do |zos|
        files(type) do |file|
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
