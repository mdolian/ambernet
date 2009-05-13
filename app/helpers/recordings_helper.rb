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
    
    def first_zip_link(filetype)
      if File.exist?("public/ambernet/zips/#{@recording.label}.#{filetype}.zip")
        "<a href='/ambernet/zips/#{@recording.label}.#{filetype}.zip'>zip</a>"
      else
        if File.exist?("public/ambernet/zips/#{@recording.label}.#{filetype}.zip.lock")
          "Generating..."
        else
          "<a href='#')>Generate</a>"
        end
      end
    end
  end
end # Merb