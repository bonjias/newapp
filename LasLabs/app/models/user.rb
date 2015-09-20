require 'crypt_keeper'

class User < ActiveRecord::Base

  has_one :authorized_user, foreign_key: 'email', primary_key: 'email'
  has_one :companies, foreign_key: 'id', primary_key: 'company_id'
  # Qbo cols
  crypt_keeper :enc_qbo_token, :enc_qbo_secret, :enc_qbo_company_id, encryptor: :aes_new, key: "SuperSecretPassword!!", salt: "1988L@$L@b$?!"
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
  
  def admin?
    admin
    email == 'dave@dlasley.net'
  end
  
end
