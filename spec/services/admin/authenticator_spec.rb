require 'rails_helper'

describe Admin::Authenticator do
  describe '#authenticate' do
    example '存在するなら true を返す' do
      m = build(:administrator)
      expect(Admin::Authenticator.new(m).authenticate).to be_truthy
    end

    example '停止フラグが立っていればtrueを返す' do
      m = build(:staff_member, suspended: true)
      expect(Admin::Authenticator.new(m).account_lock?).to be_truthy
    end

  end
end
