require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/venues" do
  before(:each) do
    @response = request("/venues")
  end
end