require 'test_helper'

class AuthorizedUsersControllerTest < ActionController::TestCase
  setup do
    @authorized_user = authorized_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:authorized_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create authorized_user" do
    assert_difference('AuthorizedUser.count') do
      post :create, authorized_user: { company: @authorized_user.company, email: @authorized_user.email }
    end

    assert_redirected_to authorized_user_path(assigns(:authorized_user))
  end

  test "should show authorized_user" do
    get :show, id: @authorized_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @authorized_user
    assert_response :success
  end

  test "should update authorized_user" do
    patch :update, id: @authorized_user, authorized_user: { company: @authorized_user.company, email: @authorized_user.email }
    assert_redirected_to authorized_user_path(assigns(:authorized_user))
  end

  test "should destroy authorized_user" do
    assert_difference('AuthorizedUser.count', -1) do
      delete :destroy, id: @authorized_user
    end

    assert_redirected_to authorized_users_path
  end
end
