require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/beta" do
  before(:each) do
    @response = request("/beta")
  end
end