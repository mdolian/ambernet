require 'open-uri'
class Setlists < Application

  def index
    render
  end
  
  def scrape
    song_list=[]
    set=1
    song_order=1
    is_segue = "false"
    print=""
    seg_str=""
    song_id=0
    doc = Hpricot(open("http://perpetualarchives.mongoosecommunication.com/shows.asp?show_ID=#{params["id"]}"))
    setlist = (doc/"#linear_#{params["id"]}/tr/td").inner_html
    setlist.gsub!('<b>','').gsub!('</b>','').gsub!('<br />','').gsub!('1st Set:','')
    setlist.each(',') do |song|
      set = set + 1 if song.slice!('2nd Set:') || song.slice!('3rd Set:') || song.slice!('4th Set:')
      set = 9 if song.slice!('Encore:')
      if song.include?('&gt;') 
        puts "BLAH #{song}"
        song.each('&gt;') do |segue|
          is_segue = 'true' if(segue.slice!('&gt;'))
          is_segue = 'false' if(segue.slice!(','))
          puts "SEG: #{segue.lstrip!}"
          setlist_new = Setlist.new(
            :show_id => params["id"],
            :set_id => set.to_s,
            :song_order => song_order,
            :is_segue => is_segue,
            :song_id => Song.all(:song_name => segue)[0].id)  
          seg_str = ">" if is_segue == 'true'
          print << "#{song_order.to_s} Set #{set.to_s}: #{segue} #{seg_str} <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Song ID: #{setlist_new.song_id}<br>"  
          seg_str = ''  
          is_segue = 'false'    
          song_order = song_order + 1
        end 
      else 
        song.strip!
        song.gsub!("<div class=\"notes\"></div","")    
        puts "BLHA" if song.include?("<div class=\"notes\"></div")  
        setlist_new = Setlist.new(
          :show_id => params["id"],
          :set_id => set.to_s,
          :song_order => song_order,
          :is_segue => is_segue,
          :song_id => Song.all(:song_name => song.chop!)[0].id)
        print << "#{song_order.to_s} Set #{set.to_s}: #{song} #{seg_str} <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Song ID: #{setlist_new.song_id}<br>"  
        song_order = song_order + 1        
      end      
      is_segue = "false"
    end
    print << "<br><br>Full Setlist before Parsing: <br><br> 1st Set: #{setlist}"    
    render print, :layout => false
  end
  
end
