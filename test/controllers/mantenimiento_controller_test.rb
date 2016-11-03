require 'test_helper'

class MantenimientoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get mantenimiento_index_url
    assert_response :success
  end

end
