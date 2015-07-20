class Question
  include Mongoid::Document
  field :question, type: String
  field :number, type: String
  field :explanation, type: String
  field :original_source, type: String

  has_and_belongs_to_many :question_sets
  embeds_many :answers
end
