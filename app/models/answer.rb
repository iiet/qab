class Answer
  include Mongoid::Document
  include Mongoid::History::Trackable
  include Mongoid::Userstamp

  field :answer, type: String
  field :correct, type: Mongoid::Boolean
  field :letter, type: String

  embedded_in :question

  track_history :on => [:answer, :letter, :correct], :scope => :question, :track_create => true, :track_destroy => true
end
