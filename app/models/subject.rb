class Subject
  include Mongoid::Document
  field :name, type: String
  field :study_semester, type: Integer

  has_many :question_sets, dependent: :restrict

  validates_presence_of :name, :study_semester
  validates_numericality_of :study_semester, only_integer: true, greater_than: 0

  rails_admin do
    edit do
      exclude_fields :id, :question_sets
    end
  end
end
