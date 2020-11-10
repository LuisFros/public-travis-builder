class User < ApplicationRecord
    validates :username, uniqueness: true, presence: true
    has_many :invitations
    has_many :rooms, through: :invitations
    has_many :created_rooms, foreign_key: "user_id", class_name: "Room"

    has_and_belongs_to_many :rooms
end
