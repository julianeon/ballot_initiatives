require 'test_helper'

class InitiativesControllerTest < ActionController::TestCase
  setup do
    @initiative = initiatives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:initiatives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create initiative" do
    assert_difference('Initiative.count') do
      post :create, initiative: { description: @initiative.description, election_date: @initiative.election_date, initiator: @initiative.initiator, measure_type: @initiative.measure_type, no_count: @initiative.no_count, pass_fail: @initiative.pass_fail, percent_required: @initiative.percent_required, prop_letter: @initiative.prop_letter, scan_url: @initiative.scan_url, title: @initiative.title, yes_count: @initiative.yes_count }
    end

    assert_redirected_to initiative_path(assigns(:initiative))
  end

  test "should show initiative" do
    get :show, id: @initiative
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @initiative
    assert_response :success
  end

  test "should update initiative" do
    patch :update, id: @initiative, initiative: { description: @initiative.description, election_date: @initiative.election_date, initiator: @initiative.initiator, measure_type: @initiative.measure_type, no_count: @initiative.no_count, pass_fail: @initiative.pass_fail, percent_required: @initiative.percent_required, prop_letter: @initiative.prop_letter, scan_url: @initiative.scan_url, title: @initiative.title, yes_count: @initiative.yes_count }
    assert_redirected_to initiative_path(assigns(:initiative))
  end

  test "should destroy initiative" do
    assert_difference('Initiative.count', -1) do
      delete :destroy, id: @initiative
    end

    assert_redirected_to initiatives_path
  end
end
