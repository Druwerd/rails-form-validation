require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { build(:user) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to allow_value('user@example.com').for(:email) }
    it { is_expected.not_to allow_value('invalid_email').for(:email) }

    it { is_expected.to validate_length_of(:password).is_at_least(12) }
    it { is_expected.to allow_value('Abcdefghij1!').for(:password) }
    it do
      is_expected.not_to allow_value('p').for(:password)
        .with_message(/is too short \(minimum is 12 characters\)/)
      is_expected.not_to allow_value('p').for(:password)
        .with_message(/must contain at least one uppercase letter/)
      is_expected.not_to allow_value('P'.upcase).for(:password)
        .with_message(/must contain at least one lowercase letter/)
      is_expected.not_to allow_value('p').for(:password)
        .with_message(/must contain at least one number/)
      is_expected.not_to allow_value('p').for(:password)
        .with_message(/must contain at least one special character/)
    end

    User::ALLOWED_PASSWORD_SPECIAL_CHARS.each do |char|
      it { is_expected.to allow_value("Abcdefghij1#{char}").for(:password) }
    end

    it { is_expected.to have_secure_password }
  end
end
