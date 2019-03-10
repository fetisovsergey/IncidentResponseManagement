require 'test_helper'

class RemoteControlCentersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @remote_control_center = remote_control_centers(:one)
  end

  test "should get index" do
    get remote_control_centers_url
    assert_response :success
  end

  test "should get new" do
    get new_remote_control_center_url
    assert_response :success
  end

  test "should create remote_control_center" do
    assert_difference('RemoteControlCenter.count') do
      post remote_control_centers_url, params: { remote_control_center: { botnet_id: @remote_control_center.botnet_id, country: @remote_control_center.country, description: @remote_control_center.description, domain: @remote_control_center.domain, ip: @remote_control_center.ip } }
    end

    assert_redirected_to remote_control_center_url(RemoteControlCenter.last)
  end

  test "should show remote_control_center" do
    get remote_control_center_url(@remote_control_center)
    assert_response :success
  end

  test "should get edit" do
    get edit_remote_control_center_url(@remote_control_center)
    assert_response :success
  end

  test "should update remote_control_center" do
    patch remote_control_center_url(@remote_control_center), params: { remote_control_center: { botnet_id: @remote_control_center.botnet_id, country: @remote_control_center.country, description: @remote_control_center.description, domain: @remote_control_center.domain, ip: @remote_control_center.ip } }
    assert_redirected_to remote_control_center_url(@remote_control_center)
  end

  test "should destroy remote_control_center" do
    assert_difference('RemoteControlCenter.count', -1) do
      delete remote_control_center_url(@remote_control_center)
    end

    assert_redirected_to remote_control_centers_url
  end
end
