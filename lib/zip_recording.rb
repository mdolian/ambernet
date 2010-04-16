require 'zip/zip'
require 'resque'

class ZipRecording
  @queue = :default

  def self.queue
    name.underscore.to_sym
  end

  def self.enqueue(*args)
    Resque.enqueue(self, *args)
  end

  def self.perform(label, type, files)
    if !File.exist?("public/zips/#{label}.#{type}.zip")
      t = File.open("public/zips/#{label}.#{type}.zip", "w")
      Zip::ZipOutputStream.open(t.path) do |zos|
        files.each do |filename|
          file = File.open(filename)
          zos.put_next_entry(File.basename(file.path))
          zos.print IO.read(file.path)
        end
      end
      t.close
    end
  end
end
