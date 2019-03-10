require 'test_helper'

class BotnetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @botnet = botnets(:one)
  end

  test "should get index" do
    get botnets_url
    assert_response :success
  end

  test "should get new" do
    get new_botnet_url
    assert_response :success
  end

  test "should create botnet" do
    assert_difference('Botnet.count') do
      post botnets_url, params: { botnet: { description: @botnet.description, name: @botnet.name } }
    end

    assert_redirected_to botnet_url(Botnet.last)
  end

  test "should show botnet" do
    get botnet_url(@botnet)
    assert_response :success
  end

  test "should get edit" do
    get edit_botnet_url(@botnet)
    assert_response :success
  end

  test "should update botnet" do
    patch botnet_url(@botnet), params: { botnet: { description: @botnet.description, name: @botnet.name } }
    assert_redirected_to botnet_url(@botnet)
  end

  test "should destroy botnet" do
    assert_difference('Botnet.count', -1) do
      delete botnet_url(@botnet)
    end

    assert_redirected_to botnets_url
  end
end
