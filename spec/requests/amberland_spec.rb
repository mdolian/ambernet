require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/amberland" do
  before(:each) do
    @response = request("/amberland")
  end
end