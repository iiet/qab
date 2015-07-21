class Subject
  include Mongoid::Document
  field :name, type: String
  field :study_semester, type: Integer

  has_many :question_sets, dependent: :restrict

  validates_presence_of :name, :study_semester
end
