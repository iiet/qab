class Subject
  include Mongoid::Document
  field :name, type: String
  field :study_semester, type: Integer
  field :question_sets_count, type: Integer, default: 0

  has_many :question_sets, dependent: :restrict

  validates_presence_of :name, :study_semester
  validates_numericality_of :study_semester, only_integer: true, greater_than: 0
end
