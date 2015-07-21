class Question
  include Mongoid::Document
  include Mongoid::History::Trackable
  include Mongoid::Userstamp

  field :question, type: String
  field :number, type: String
  field :explanation, type: String
  field :changelog, type: Array, default: []

  has_and_belongs_to_many :question_sets
  embeds_many :answers
  embeds_many :comments

  track_history   :on => [:question, :number, :explanation],
                  :version_field => :version,
                  :track_update   =>  true
end
