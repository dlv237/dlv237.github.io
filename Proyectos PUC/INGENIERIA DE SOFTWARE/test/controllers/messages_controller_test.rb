require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
    setup do
        @usuario = usuarios(:usuario_one) # Assuming users fixture is available
      @room = rooms(:room_one) # Assuming rooms fixture is available
      sign_in @usuario
    end

    test "should create message" do
        assert_difference('Message.count') do
            post room_messages_url(@room), params: { message: { body: 'Buenos dias' } }
        end
    end

    teardown do
          Rails.cache.clear
      end
end
