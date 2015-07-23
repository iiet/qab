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

  def modify_from_importer_data(converted_data)
    converted_data[:questions].each do |q|
      self.questions << Question.new(q)
    end
    self.options = converted_data[:options]
  end

  def self.from_importer_data(converted_data)
    qs = QuestionSet.new
    qs.modify_from_importer_data(converted_data)
    qs
  end

  def self.from_string(data)
    from_importer_data(::QuestionsImporter.new.from_string(data))
  end

  def full_name
    "#{subject.name}/#{name}"
  end
end
