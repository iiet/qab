class Question
  include Mongoid::Document
  field :question, type: String
  field :explanation, type: String
  has_and_belongs_to_many :question_sets
  embeds_many :answers
end
