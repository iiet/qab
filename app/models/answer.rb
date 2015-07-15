class Answer
  include Mongoid::Document
  field :answer, type: String
  field :correct, type: Mongoid::Boolean
  embedded_in :question
end
