class Invitation < ApplicationRecord
    belongs_to :receiver, :class_name => "User"
    belongs_to :sender, :class_name => "User"
    belongs_to :room
end
