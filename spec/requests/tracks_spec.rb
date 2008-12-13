require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/tracks" do
  before(:each) do
    @response = request("/tracks")
  end
end