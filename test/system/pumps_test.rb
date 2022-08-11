require "application_system_test_case"

class PumpsTest < ApplicationSystemTestCase
  setup do
    @pump = pumps(:one)
  end

  test "visiting the index" do
    visit pumps_url
    assert_selector "h1", text: "Pumps"
  end

  test "creating a Pump" do
    visit pumps_url
    click_on "New Pump"

    fill_in "Description", with: @pump.description
    fill_in "Graph points", with: @pump.graph_points
    fill_in "Link", with: @pump.link
    fill_in "Name", with: @pump.name
    fill_in "Phase", with: @pump.phase
    fill_in "Pump assembly", with: @pump.pump_assembly
    fill_in "Pump type", with: @pump.pump_type
    fill_in "Volt", with: @pump.volt
    click_on "Create Pump"

    assert_text "Pump was successfully created"
    click_on "Back"
  end

  test "updating a Pump" do
    visit pumps_url
    click_on "Edit", match: :first

    fill_in "Description", with: @pump.description
    fill_in "Graph points", with: @pump.graph_points
    fill_in "Link", with: @pump.link
    fill_in "Name", with: @pump.name
    fill_in "Phase", with: @pump.phase
    fill_in "Pump assembly", with: @pump.pump_assembly
    fill_in "Pump type", with: @pump.pump_type
    fill_in "Volt", with: @pump.volt
    click_on "Update Pump"

    assert_text "Pump was successfully updated"
    click_on "Back"
  end

  test "destroying a Pump" do
    visit pumps_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pump was successfully destroyed"
  end
end
