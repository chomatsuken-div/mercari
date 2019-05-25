class SnsCredential < ApplicationRecord
  belongs_to :user, optional: true

  def self.from_omniauth(auth)
    sns = where(provider: auth.provider, uid: auth.uid).first_or_create
    user = sns.user || User.new(
      nickname: auth.info.name,
      email: auth.info.email
    )
    { user: user, sns_id: sns.id }
  end

end
