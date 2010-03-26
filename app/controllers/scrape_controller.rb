class ScrapeController < ApplicationController

  before_filter :authenticate_admin!
  
  def perpetual_archives
    require 'rubygems'
    require 'hpricot'
    require 'open-uri'
    case params["id"]
    when "all" then 
      for i in 483..1500 do
        logger.info "Show ID: #{i}"
        if i != 1143 then
          doc = Hpricot(open("http://perpetualarchives.mongoosecommunication.com/shows.asp?show_ID=#{i}"))
          parse_and_insert_show(i, doc)
          parse_and_insert_setlist(i, doc)
          flash[:notice] = "All of the setlists have been scraped... bitch!"
        end
      end  
    when "update" then
      show_id = Show.order("show.id desc").first.id
      venue_name = "start"
      while venue_name != "" do
        show_id = show_id + 1
        doc = Hpricot(open("http://perpetualarchives.mongoosecommunication.com/shows.asp?show_ID=#{show_id}"))
        parse_and_insert_show(show_id, doc)
        parse_and_insert_setlist(show_id, doc)
        flash[:notice] = "Updationplete.  All your setlist are belong to us... bitch!"         
      end             
    else
      show_id = params["id"]
      doc = Hpricot(open("http://perpetualarchives.mongoosecommunication.com/shows.asp?show_ID=#{show_id}"))
      parse_and_insert_show(show_id, doc)
      parse_and_insert_setlist(show_id, doc)
      flash[:notice] = "That setlist has been ripped bitch!" 
    end
    render 
  end
  
  def parse_and_insert_show(show_id, doc)
    venue_name = doc.search("//td[@align='left'][@valign='top']/b").inner_html
    logger.info "VENUE: #{venue_name}"
    show_info = doc.search("//td[@align='left'][@valign='top']").inner_html.split('<br />')
    if venue_name == "" then
      notice[:error] = "Show does not exist in Perpetual Archives"
    else
      date_played, city_state = show_info[2].strip!, show_info[1].split(",")
      venue_city, venue_state = city_state[0].strip!, city_state[1].strip! 
      venue = Venue.where("venue_name = ?", venue_name).first
      if venue.nil? then
        venue = Venue.create(:venue_name => venue_name, :venue_city => venue_city, :venue_state => venue_state)
        venue.save
        venue_id = venue.id
      else
        venue_id = venue.id
      end    
      if !Show.where("id = ?", show_id).nil? then
        # this is a hack because AR would not let me set the id attribute manually
        ActiveRecord::Base.connection.execute("INSERT INTO `shows` (`date_played`, `id`, `show_notes`, `venue_id`) VALUES ('#{date_played.to_date}', #{show_id}, NULL, #{venue_id})")
      end   
    end
  end
  
  def parse_and_insert_setlist(show_id, doc)
    setlist_text = (doc/"#linear_#{show_id}/tr/td").inner_html
    if setlist_text == "" then
      notice[:error] = "Setlist does not exist in Perpetual Archives"
    else
      setlist = Setlist.where("show_id = ?", show_id)
      if setlist[0] == nil then
        set, song_order, is_segue = 1, 1, false
        setlist_text.gsub!('<b>','').gsub!('</b>','').gsub!('<br />','').gsub!('&gt;',', >, ')
        logger.info "Setlist: #{setlist_text}"
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
            setlist.is_segue = true
          else
            song_id = parse_and_insert_song(song.chop!)        
            setlist = Setlist.create(
                :show_id => show_id,
                :set_id => set,
                :song_order => song_order,
                :is_segue => false,
                :song_id => song_id)
            song_order = song_order + 1
          end
          setlist.save  
          logger.info "#{song_order} - Set: #{set} - Song ID: #{song_id} - #{is_segue}"  
        end             
      end   
    end
  end
   
  def parse_and_insert_song(song_name)
    song_name = song_name.split('<')[0]
    song_name.strip!    
    # This is a hack - GUUUUUU!!!
    song_name = "Didn't Leave Nobody But The Baby" if song_name.include?('Leave Nobody But The Baby') 
    song = Song.where("song_name = ?", song_name)
    if song[0] == nil then
      song = Song.create(:song_name => song_name) 
      song.save
      logger.info "Song Name: #{song_name}"
      song_id = song.id
    else
      logger.info "Song Name: #{song_name}"      
      song_id = song[0].id
    end
  end 
  
end
