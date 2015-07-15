class User
  include Mongoid::Document
  field :username, type: String
  has_many :comments
end
