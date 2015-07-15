class QuestionSet
  include Mongoid::Document
  field :name, type: String
  belongs_to :subject
  has_and_belongs_to_many :questions
end
