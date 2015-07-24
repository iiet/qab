class HistoryTracker
  include Mongoid::History::Tracker
  include Mongoid::Timestamps
end