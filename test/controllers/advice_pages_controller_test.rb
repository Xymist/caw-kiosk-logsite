require 'test_helper'

class AdvicePagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @advice_page = advice_pages(:one)
  end

  test "should get index" do
    get advice_pages_url
    assert_response :success
  end

  test "should get new" do
    get new_advice_page_url
    assert_response :success
  end

  test "should create advice_page" do
    assert_difference('AdvicePage.count') do
      post advice_pages_url, params: { advice_page: {  } }
    end

    assert_redirected_to advice_page_path(AdvicePage.last)
  end

  test "should show advice_page" do
    get advice_page_url(@advice_page)
    assert_response :success
  end

  test "should get edit" do
    get edit_advice_page_url(@advice_page)
    assert_response :success
  end

  test "should update advice_page" do
    patch advice_page_url(@advice_page), params: { advice_page: {  } }
    assert_redirected_to advice_page_path(@advice_page)
  end

  test "should destroy advice_page" do
    assert_difference('AdvicePage.count', -1) do
      delete advice_page_url(@advice_page)
    end

    assert_redirected_to advice_pages_path
  end
end
