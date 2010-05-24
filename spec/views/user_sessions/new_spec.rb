require File.dirname(__FILE__) + '/../../spec_helper'

describe "/user_sessions/new" do
  
  before do
    activate_authlogic
    @user_session = UserSession.new
  end

  # it "should display login form" do
  #   render '/user_sessions/new'
  #   response.should have_tag("form[action=/login]") do
  #     with_tag("input[type=text][name=login]")
  #     with_tag("input[type=password][name=password]")
  #     with_tag("input[type=submit][value=Login]")
  #   end 
  # end
end