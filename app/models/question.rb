class Question
  include Mongoid::Document
  include Mongoid::History::Trackable
  include Mongoid::Userstamp

  field :question, type: String
  field :number, type: String
  field :explanation, type: String
  field :original_source, type: String

  has_and_belongs_to_many :question_sets

  embeds_many :answers
  embeds_many :comments

  accepts_nested_attributes_for :answers, reject_if: :all_blank#, allow_destroy: true
  accepts_nested_attributes_for :comments, reject_if: :all_blank#, allow_destroy: true

  track_history   :on => [:question, :number, :explanation],
                  :version_field => :version,
                  :track_update   =>  true

  validates_presence_of :question, :number
  validates :number, length: { in: 1..4 }

  def name # for rails admin
    question.first(40)
  end
end
