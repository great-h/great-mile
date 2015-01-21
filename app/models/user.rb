class User < ActiveRecord::Base
  def self.find_and_update_or_create_for_omniauth(auth)
    first_or_initialize(uid: auth['uid']).tap do |user|
      attrs = {
               uid: auth['uid'],
               nickname: auth['info']['nickname'],
               image: auth['info']['nickname'],
               url: auth['info']['GitHub'],
               token: auth['credentials']['token'],
              }
      user.update!(attrs)
    end
  end

  def github_client
    Github.client(self)
  end

  def repos
    github_client.list_repos(nickname)
  end
end
