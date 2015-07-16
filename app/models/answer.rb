class Answer
  include Mongoid::Document
  field :answer, type: String
  field :correct, type: Mongoid::Boolean
  field :letter, type: String

  embedded_in :question
end
