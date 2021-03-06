class Comment
  include Mongoid::Document

  embedded_in :question

  field :body, type: String
  belongs_to :user

  validates_presence_of :body, :user
end
