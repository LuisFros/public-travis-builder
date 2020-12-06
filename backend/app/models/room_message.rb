class RoomMessage < ApplicationRecord
  belongs_to :room, touch: false, inverse_of: :room_messages
  belongs_to :user

  after_create :set_original_msg

  def set_original_msg
    self.original_msg = message
  end

end
