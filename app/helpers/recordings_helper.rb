module Merb
  module RecordingsHelper
    def get_discs
      [["0", "0"],
       ["1", "1"], 
       ["2", "2"], 
       ["3", "3"], 
       ["4", "4"], 
       ["5", "5"], 
       ["6", "6"],
       ["7", "7"],
       ["8", "8"],
       ["9", "9"]]
    end
    
    def zip_link(filetype)
      extension = filetype == "lossless" ? @recording.lossless_extension : 'mp3'
      if File.exist?("public/ambernet/zips/#{@recording.label}.#{extension}.zip")
        "<a href='/ambernet/zips/#{@recording.label}.#{extension}.zip'>zip</a>"
      else
        if File.exist?("public/ambernet/zips/#{@recording.label}.#{extension}.zip.lock")
          "Generating"
        else
          "<a href='/recordings/zip/#{@recording.id}/#{filetype}'>Generate</a>"
        end
      end
    end
  end
end # Merb