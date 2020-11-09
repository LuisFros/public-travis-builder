require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'attributes' do
    it "its invalid without username" do
      expect(User.new).to_not be_valid
    end
    it "its valid with username" do
      expect(User.new(username:'r2d2')).to be_valid
    end
  end
end
