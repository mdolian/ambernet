require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/shows" do
  before(:each) do
    @response = request("/shows")
  end
end