require 'open-uri'
class ScrapeController < ApplicationController

  # From Merb, to be implemented
  #before :ensure_authenticated

  def perpetual_archives
    case params["id"]
    when "all" then 
      for i in 483..1500 do
        Merb.logger.info "Show ID: #{i}"
        if i != 1143 then
          doc = Hpricot(open("http://perpetualarchives.mongoosecommunication.com/shows.asp?show_ID=#{i}"))
          parse_and_insert_show(i, doc)
          parse_and_insert_setlist(i, doc)
          message[:notice] = "All of the setlists have been scraped... bitch!"
        end
      end  
    when "update" then
      show_id = Show.all(:order => [:id.desc])[0].id
      venue_name = "start"
      while venue_name != "" do
        show_id = show_id + 1
        doc = Hpricot(open("http://perpetualarchives.mongoosecommunication.com/shows.asp?show_ID=#{show_id}"))
        parse_and_insert_show(show_id, doc)
        parse_and_insert_setlist(show_id, doc)
        message[:notice] = "Updationplete.  All your setlist are belong to us... bitch!"         
      end             
    else
      show_id = params["id"]
      doc = Hpricot(open("http://perpetualarchives.mongoosecommunication.com/shows.asp?show_ID=#{show_id}"))
      parse_and_insert_show(show_id, doc)
      parse_and_insert_setlist(show_id, doc)
      message[:notice] = "That setlist has been ripped bitch!" 
    end
    render 
  end
  
  def parse_and_insert_show(show_id, doc)
    venue_name = doc.search("//td[@align='left'][@valign='top']/b").inner_html
    Merb.logger.info "VENUE: #{venue_name}"
    show_info = doc.search("//td[@align='left'][@valign='top']").inner_html.split('<br />')
    if venue_name == "" then
      message[:error] = "Show does not exist in Perpetual Archives"
    else
      date_played, city_state = show_info[2].strip!, show_info[1].split(",")
      venue_city, venue_state = city_state[0].strip!, city_state[1].strip! 
      venue = Venue.all(:venue_name => venue_name)
      if venue[0].nil? then
        venue = Venue.new(:venue_name => venue_name, :venue_city => venue_city, :venue_state => venue_state)
        venue.save
        venue_id = venue.id
      else
        venue_id = venue[0].id
      end    
      show = Show.get(show_id)
      if show == nil then
        show = Show.new(:id => show_id, :date_played => date_played, :venue_id => venue_id)
        show.save
      end   
    end
  end
  
  def parse_and_insert_setlist(show_id, doc)
    setlist_text = (doc/"#linear_#{show_id}/tr/td").inner_html
    if setlist_text == "" then
      message[:error] = "Setlist does not exist in Perpetual Archives"
    else
      setlist = Setlist.all(:show_id => show_id)
      if setlist[0] == nil then
        set, song_order, is_segue = 1, 1, "false"
        setlist_text.gsub!('<b>','').gsub!('</b>','').gsub!('<br />','').gsub!('&gt;',', >, ')
        Merb.logger.info "Setlist: #{setlist_text}"
        # This is a hack - GUUUUUU!!!
        if setlist_text.include?('1st Set:') then
          setlist_text.gsub!('1st Set:','') 
        else
          setlist_text.gsub!('\r\n','')
          setlist_text.strip!
        end
        setlist_text.each(',') do |song|
          set = set +1  if song.slice!('2nd Set:') || song.slice!('3rd Set:') || song.slice!('4th Set:')
          set = 9       if song.slice!('Encore:')  
          if song == ' >,' then
            setlist.is_segue = 'true'
          else
            song_id = parse_and_insert_song(song.chop!)        
            setlist = Setlist.new(
                :show_id => show_id,
                :set_id => set,
                :song_order => song_order,
                :is_segue => 'false',
                :song_id => song_id)
            song_order = song_order + 1
          end
          setlist.save  
          Merb.logger.info "#{song_order} - Set: #{set} - Song ID: #{song_id} - #{is_segue}"  
        end             
      end   
    end
  end
   
  def parse_and_insert_song(song_name)
    song_name = song_name.split('<')[0]
    song_name.strip!    
    # This is a hack - GUUUUUU!!!
    song_name = "Didn't Leave Nobody But The Baby" if song_name.include?('Leave Nobody But The Baby') 
    song = Song.all(:song_name => song_name)
    if song[0] == nil then
      song = Song.new(:song_name => song_name) 
      song.save
      Merb.logger.info "Song Name: #{song_name}"
      song_id = song.id
    else
      Merb.logger.info "Song Name: #{song_name}"      
      song_id = song[0].id
    end
  end 
  
end
