class Room < ApplicationRecord
    has_many :room_messages, dependent: :destroy,
                         inverse_of: :room
    has_many :invitations
    has_many :users, through: :invitations

    has_and_belongs_to_many :users
    def self.cache_key(rooms)
        {
        serializer: 'rooms', 
        start_record: rooms.maximum(:updated_at)
        }
    end

    after_touch :create_json_cache

    private

    def create_json_cache
        CreateRoomsJsonCacheJob.perform_now
    end
end
