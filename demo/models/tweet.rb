class Tweet
  attr_accessor :username, :status

  ALL_TWEETS = []

  def initialize(username, status)
    @username = username
    @status = status
    ALL_TWEETS << self
  end

  def self.all
    ALL_TWEETS
  end
end