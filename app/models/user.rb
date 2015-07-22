class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and
  devise :database_authenticatable, :registerable, :omniauthable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  field :username, type: String
  field :first_name, type: String
  field :last_name, type: String
  field :accounts_api_id, type: String

  has_many :comments

  def self.find_for_accounts_api(data)
    @user = User.find_by(accounts_api_id: data['uid'])
    unless @user
      @user = User.create!(
        email: data['info']['email'],
        accounts_api_id: data['uid'],
        password: Devise.friendly_token.first(10),
        first_name: data['info']['first_name'],
        last_name: data['info']['last_name'],
        username: data['info']['username']
      )
    end
    @user
  end

  def full_name
    "#{first_name} #{last_name} (#{username})"
  end

end
