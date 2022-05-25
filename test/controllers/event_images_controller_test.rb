require 'test_helper'

class EventImagesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get event_images_create_url
    assert_response :success
  end

end
