class Subject
  include Mongoid::Document
  field :name, type: String
  field :study_semester, type: Integer
end
