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
    
    def zip_link_helper(filetype)
      if File.exist?("public/ambernet/zips/#{@recording.label}.#{filetype}.zip")
        "<a href='/ambernet/zips/#{@recording.label}.#{filetype}.zip'><div id='status_#{filetype}'>zip</div></a>"
      else
        if File.exist?("public/ambernet/zips/#{@recording.label}.#{filetype}.zip.lock")
          "<img src='/images/loading.gif'/><br><div id='status_#{filetype}'></div>"
        else
          "<a href='#' id='zip_link_#{filetype}'><div id='status_#{filetype}'>Generate</div></a>"
        end
      end
    end
  end
end # Merb