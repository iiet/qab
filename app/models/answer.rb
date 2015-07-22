class Answer
  include Mongoid::Document
  include Mongoid::History::Trackable
  include Mongoid::Userstamp

  field :answer, type: String
  field :correct, type: Mongoid::Boolean
  field :letter, type: String

  validates_presence_of :answer, :letter
  validates :letter, inclusion: 'A'..'Z'
  # TODO letter uniqueness validation

  embedded_in :question
  track_history :on => [:answer, :letter, :correct], :scope => :question, :track_create => true, :track_destroy => true

  def name # for rails admin
    "#{letter}) #{answer.first(20)}"
  end

  before_validation do
    self.letter = letter.upcase
  end
end
