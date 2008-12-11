require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a secret exists" do
  Secret.all.destroy!
  request(resource(:secrets), :method => "POST", 
    :params => { :secret => { :id => nil }})
end

describe "resource(:secrets)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:secrets))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of secrets" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a secret exists" do
    before(:each) do
      @response = request(resource(:secrets))
    end
    
    it "has a list of secrets" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Secret.all.destroy!
      @response = request(resource(:secrets), :method => "POST", 
        :params => { :secret => { :id => nil }})
    end
    
    it "redirects to resource(:secrets)" do
      @response.should redirect_to(resource(Secret.first), :message => {:notice => "secret was successfully created"})
    end
    
  end
end

describe "resource(@secret)" do 
  describe "a successful DELETE", :given => "a secret exists" do
     before(:each) do
       @response = request(resource(Secret.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:secrets))
     end

   end
end

describe "resource(:secrets, :new)" do
  before(:each) do
    @response = request(resource(:secrets, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@secret, :edit)", :given => "a secret exists" do
  before(:each) do
    @response = request(resource(Secret.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@secret)", :given => "a secret exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Secret.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @secret = Secret.first
      @response = request(resource(@secret), :method => "PUT", 
        :params => { :secret => {:id => @secret.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@secret))
    end
  end
  
end

