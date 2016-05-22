class User < ActiveRecord::Base

	has_many :test_sets

	def self.find_or_create_with_omniauth(auth)
	user = self.where(uid: auth[:uid], provider: auth[:provider]).first_or_create
    #user = self.find_or_create_by_provider_and_uid(auth.provider, auth.uid)
    user.assign_attributes({ name: auth.info.name, email: auth.info.email, access_token: auth.credentials.token })
    user.save!
    user
  end
end
