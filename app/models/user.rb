class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:twitter]
         has_many :goals
         has_many :user_logs
         
    def status_with friend_id
        if friend = Friend.where(user_id: self.id, friend_id: friend_id).try(:first)
          if friend.accepted
            :be_accepted
          else
            :requested
          end
        elsif friend = Friend.where(user_id: friend_id, friend_id: self.id).try(:first)
          if friend.accepted
            :accepted
          else
            :be_requested
          end
        else
          :nothing
        end
    end
      
    def friends
        Friend.where("user_id = ? or friend_id = ?", self.id, self.id)
    end
    
    def self.from_omniauth(auth)
      # providerとuidでUserレコードを取得する
      # 存在しない場合は、ブロック内のコードを実行して作成する
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        # auth.provider には "twitter"、
        # auth.uidには twitterアカウントに基づいた個別のIDが入っている
        # first_or_createメソッドが自動でproviderとuidを設定してくれるので、
        # ここでは設定は必要ない
        user.name = auth.info.nickname # twitterで利用している名前が入る
        user.email = auth.info.email # twitterの場合入らない
        # user.password = Devise.friendly_token[0,20]
        # user.image = auth.info.image
      end
    end
    
    def self.new_with_session(params, session)
      if session["devise.user_attributes"]
        new(session["devise.user_attributes"], without_protection: true) do |user|
          user.attributes = params
          user.valid?
        end
      else
        super
      end
    end
end
