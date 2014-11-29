class Tweet
  attr_accessor :username, :status

  ALL = []

  def initialize(username, status)
    @username = username
    @status = status
    ALL << self
  end

  def self.all
    ALL
  end
end