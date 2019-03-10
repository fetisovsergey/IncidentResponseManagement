require 'test_helper'

class InfectedMachinesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @infected_machine = infected_machines(:one)
  end

  test "should get index" do
    get infected_machines_url
    assert_response :success
  end

  test "should get new" do
    get new_infected_machine_url
    assert_response :success
  end

  test "should create infected_machine" do
    assert_difference('InfectedMachine.count') do
      post infected_machines_url, params: { infected_machine: { botnet_id: @infected_machine.botnet_id, incident_id: @infected_machine.incident_id, ip: @infected_machine.ip, mac: @infected_machine.mac, name: @infected_machine.name, organisation_id: @infected_machine.organisation_id } }
    end

    assert_redirected_to infected_machine_url(InfectedMachine.last)
  end

  test "should show infected_machine" do
    get infected_machine_url(@infected_machine)
    assert_response :success
  end

  test "should get edit" do
    get edit_infected_machine_url(@infected_machine)
    assert_response :success
  end

  test "should update infected_machine" do
    patch infected_machine_url(@infected_machine), params: { infected_machine: { botnet_id: @infected_machine.botnet_id, incident_id: @infected_machine.incident_id, ip: @infected_machine.ip, mac: @infected_machine.mac, name: @infected_machine.name, organisation_id: @infected_machine.organisation_id } }
    assert_redirected_to infected_machine_url(@infected_machine)
  end

  test "should destroy infected_machine" do
    assert_difference('InfectedMachine.count', -1) do
      delete infected_machine_url(@infected_machine)
    end

    assert_redirected_to infected_machines_url
  end
end
