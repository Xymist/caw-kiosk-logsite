require 'test_helper'

class KioskAdminControllerTest < ActionDispatch::IntegrationTest
  test "should get defaults" do
    get kiosk_admin_defaults_url
    assert_response :success
  end

end
