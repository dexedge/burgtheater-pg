require 'test_helper'

class ComposingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @composing = composings(:one)
  end

  test "should get index" do
    get composings_url
    assert_response :success
  end

  test "should get new" do
    get new_composing_url
    assert_response :success
  end

  test "should create composing" do
    assert_difference('Composing.count') do
      post composings_url, params: { composing: {  } }
    end

    assert_redirected_to composing_url(Composing.last)
  end

  test "should show composing" do
    get composing_url(@composing)
    assert_response :success
  end

  test "should get edit" do
    get edit_composing_url(@composing)
    assert_response :success
  end

  test "should update composing" do
    patch composing_url(@composing), params: { composing: {  } }
    assert_redirected_to composing_url(@composing)
  end

  test "should destroy composing" do
    assert_difference('Composing.count', -1) do
      delete composing_url(@composing)
    end

    assert_redirected_to composings_url
  end
end
