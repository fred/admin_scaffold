require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController, "Not logged in" do
  
  before(:each) do
    @user = Factory(:user_one)
    @user_valid_attributes = { 
      :login => "blahblah", 
      :email => "email@bugus.com", 
      :password => "password", 
      :password_confirmation => "password"
    }
  end
  
  test "should not show profile but redirect to login" do
    get :index
    assert_redirected_to new_user_session_path
  end

  test "should not show user but redirect to login" do
    get :show, :id => @user.id
    assert_response 302
    assert_redirected_to new_user_session_path
  end

  test "should not get edit but redirect to login" do
    get :edit, :id => @user.id
    assert_response 302
    assert_redirected_to new_user_session_path
  end

  test "should not update user but redirect to login" do
    put :update, :id => @user.id
    assert_response 302
    assert_redirected_to new_user_session_path
  end

end


describe UsersController, "Logged in as normal user" do

  before(:each) do
    activate_authlogic
    @user = Factory(:user_one)
    UserSession.create(@user)
  end

  test "should get index" do
    get :index
    assert_redirected_to account_path
    assert_not_nil assigns(:current_user)
  end
  
  test "should show user" do
    get :show
    assert_response :success
    assert_not_nil assigns(:current_user)
  end
  
  test "should get edit" do
    get :edit
    assert_response :success
    assert_not_nil assigns(:current_user)
  end
  
  test "should update user" do
    put :update, :user => { }
    assert_redirected_to account_path
  end
  
end
