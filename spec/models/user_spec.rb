# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it 'すべての属性が有効な場合は保存できる' do
      user = User.new(
        name: 'John Doe',
        email: 'john@example.com',
        gender: 'male',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end

    it '名前がない場合は無効' do
      user = User.new(name: nil)
      expect(user).to_not be_valid
      expect(user.errors[:name]).to include('名前を入力してください')
    end

    it 'メールアドレスがない場合は無効' do
      user = User.new(email: nil)
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include('メールアドレスを入力してください')
    end

    it '重複したメールアドレスは無効' do
      User.create(name: 'John', gender: 'male', email: 'test@example.com', password: 'password',
                  password_confirmation: 'password')
      user = User.new(name: 'John', gender: 'male', email: 'test@example.com', password: 'password',
                      password_confirmation: 'password')
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include('emailは既に使われています')
    end

    it 'パスワードが6文字未満の場合は無効' do
      user = User.new(password: '12345')
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include('パスワードは 6 文字以上で入力してください')
    end
  end
end
