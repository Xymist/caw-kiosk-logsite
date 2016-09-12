require 'test_helper'

class PublicKioskControllerTest < ActionDispatch::IntegrationTest
  test 'should get home' do
    get public_kiosk_home_url
    assert_response :success
  end

  test 'should get advice_topic' do
    get advice_topic_url
    assert_response :success
  end
end
