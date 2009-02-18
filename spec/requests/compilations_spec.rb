require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/compilations" do
  before(:each) do
    @response = request("/compilations")
  end
end