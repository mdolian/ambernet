require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/recordings" do
  before(:each) do
    @response = request("/recordings")
  end
end