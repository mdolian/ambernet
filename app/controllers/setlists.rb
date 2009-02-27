require 'open-uri'
class Setlists < Application

  def index
    render
  end
  
  def scrape
    doc = Hpricot(open("http://perpetualarchives.mongoosecommunication.com/shows.asp?show_ID=#{params["id"]}"))
    setlist = (doc/"#linear_#{params["id"]}").inner_html
    render setlist
  end
  
end
