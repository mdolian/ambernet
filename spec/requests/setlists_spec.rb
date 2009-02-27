require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/setlists" do
  before(:each) do
    @response = request("/setlists")
  end
end