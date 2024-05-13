require "test_helper"

class RoomTest < ActiveSupport::TestCase
    def setup
        @user_one = usuarios(:usuario_one)
      @user_two = usuarios(:usuario_two)
    end

    test "Should not save without usuario_1" do
        room = Room.new(name: "Nombre de la sala", usuario_2: @user_two, is_private: true)
      result = room.save
      assert_not result, "Saved the room without a usuario_1"
    end
    test "Should not save without usuario_2" do
        room = Room.new(name: "Nombre de la sala", usuario_1: @user_two, is_private: true)
      result = room.save
      assert_not result, "Saved the room without a usuario_2"
    end
    test "Should not save without name" do
        room = Room.new( usuario_2: @user_one ,usuario_1: @user_two, is_private: true)
      result = room.save
      assert_not result, "Saved the room without a name"
    end


end
