class QuestionSet
  include Mongoid::Document
  field :name, type: String
  field :options, type: Hash

  belongs_to :subject
  has_and_belongs_to_many :questions

  validates_presence_of :name, :subject

  def self.from_string(data)
    qs = QuestionSet.new
    converted_data = ::QuestionsImporter.new.from_string(data)
    converted_data[:questions].each do |q|
      qs.questions << Question.new(q)
    end
    qs.options = converted_data[:options]
    qs
  end
end
