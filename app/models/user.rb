class User < ActiveRecord::Base
  has_many :notes

  def self.create_with_omniauth(auth)
    create! do |user|
      user.uid = auth['uid']
      user.provider = auth['provider']
      user.nickname = auth['info']["nickname"]
      user.name = auth['info']["name"]
      user.email = auth['info']["email"]
      user.avatar_url = auth['info']["image"]
    end
  end
end
