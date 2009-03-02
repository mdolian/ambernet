require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/scrape" do
  before(:each) do
    @response = request("/scrape")
  end
end