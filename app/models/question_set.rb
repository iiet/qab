class QuestionSet
  include Mongoid::Document
  field :name, type: String
  field :options, type: Hash, default: {}

  belongs_to :subject
  has_and_belongs_to_many :questions, autosave: true

  def explanations_by_number
    Hash[
      questions.map {|q| q.explanation.present? ? [q.number, q.explanation] : nil }.compact
    ]
  end

  # Options with explanations and urls
  def merged_options
    options.merge('explanations' => explanations_by_number).select {|_,v| v.present?}
  end

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
