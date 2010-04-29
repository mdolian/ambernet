require 'zip/zip'
require 'resque'

class ZipRecording < DefaultJob

  def self.perform(label, type, files)
    begin
      if !File.exist?("public/zips/#{label}.#{type}.zip") && !File.exist?("public/zips/#{label}.#{type}.zip.tmp")
        t = File.open("public/zips/#{label}.#{type}.zip.tmp", "w")
        Zip::ZipOutputStream.open(t.path) do |zos|
          files.each do |filename|
            file = File.open(filename)
            zos.put_next_entry(File.basename(file.path))
            zos.print IO.read(file.path)
          end
        end
        t.close
        FileUtils.mv("public/zips/#{label}.#{type}.zip.tmp", "public/zips/#{label}.#{type}.zip")
      end
    rescue => msg
      puts "Error: #{msg}"
    end
  end

end
