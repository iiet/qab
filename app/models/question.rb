class Question
  include Mongoid::Document
  field :question, type: String
  field :number, type: String
  field :explanation, type: String
  field :changelog, type: Array, default: []

  has_and_belongs_to_many :question_sets
  embeds_many :answers
  embeds_many :comments

  before_save do
    self.changelog << { updated_at: Time.now, changes: diff } unless new_record?
  end

  def diff
    diff = {}
    diff.merge!(self: changes) unless changes.empty?

    answers_changes = Hash[answers.map do |a|
      !a.changes.empty? ? [a.id.to_s, a.changes] : nil
    end.compact]
    diff.merge!(answers: answers_changes) unless answers_changes.empty?

    comments_changes = Hash[comments.map do |a|
      !a.changes.empty? ? [a.id.to_s, a.changes] : nil
    end.compact]
    diff.merge!(comments: comments_changes) unless comments_changes.empty?

    diff
  end
end
