require 'rails_helper'

RSpec.describe SnsCredential, type: :model do

  describe '#create' do

    it "is invalid without a provider" do
        snscredential = build(:sns_credential, provider: nil)
        snscredential.valid?
        expect(snscredential.errors[:provider ]).to include("を入力してください")
    end

    it "is invalid without a provider" do
      snscredential = build(:sns_credential, uid: nil)
      snscredential.valid?
      expect(snscredential.errors[:uid]).to include("を入力してください")
    end

    it "is invalid with a duplicate provider and uid" do
      snscredential = create(:sns_credential)
      another_snscredential = build(:sns_credential)
      another_snscredential.valid?
      expect(another_snscredential.errors[:provider]).to include("はすでに存在します")
    end

    it "is valid with a sns_credential that has less than 6 characters " do
      snscredential = build(:sns_credential)
      expect(snscredential).to be_valid
    end
  end
end
