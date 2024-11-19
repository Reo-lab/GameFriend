require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    it "すべての属性が有効な場合は保存できる" do
      user = User.new(
        name: "John Doe",
        email: "john@example.com",
        gender: "male",
        password: "password",
        password_confirmation: "password",
      )
      expect(user).to be_valid
    end

    it "名前がない場合は無効" do
      user = User.new(name: nil)
      expect(user).to_not be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "メールアドレスがない場合は無効" do
      user = User.new(email: nil)
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "重複したメールアドレスは無効" do
      User.create(name: "John", email: "john@example.com", password: "password")
      user = User.new(name: "Jane", email: "john@example.com", password: "password")
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("has already been taken")
    end

    it "パスワードが6文字未満の場合は無効" do
      user = User.new(password: "12345")
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
  end
end
