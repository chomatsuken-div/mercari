require 'rails_helper'
describe User do
  describe '#create' do
    context 'can save' do

      it "is valid with a nickname that has less than 6 characters " do
        user = build(:user, nickname: "aaaaaa")
        expect(user).to be_valid
      end
    end

    context "can't save" do

      it "is invalid without a nickname" do
        user = build(:user, nickname: nil)
        user.valid?
        expect(user.errors[:nickname]).to include("を入力してください")
      end

      it "is invalid without a email" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end

      it "is invalid without a password" do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end

      it "is invalid with a duplicate email address" do
        user = create(:user)
        another_user = build(:user, email: user.email)
        another_user.valid?
        expect(another_user.errors[:email]).to include("はすでに存在します")
      end

      it "is invalid with a nickname that has more than 20 characters " do
        user = build(:user, nickname: "abcdefghijklmnopqrstu")
        user.valid?
        expect(user.errors[:nickname][0]).to include("は20文字以内で入力してください")
      end

    end
  end
end