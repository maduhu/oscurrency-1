require File.dirname(__FILE__) + '/../spec_helper'

describe ConnectionsController do
  integrate_views
  
  before(:each) do
    @person = login_as(:quentin)
    @contact = people(:aaron)
  end
  
  it "should protect the create page" do
    logout
    post :create
    response.should redirect_to(login_url)
  end
  
  it "should create a new connection request" do
    Connection.should_receive(:request).with(@person, @contact).
      and_return(true)
    post :create, :person_id => @contact
    response.should redirect_to(home_url)
  end
end