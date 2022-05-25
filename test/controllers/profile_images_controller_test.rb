require 'test_helper'

class ProfileImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get profile_images_create_url
    assert_response :success
  end

end
