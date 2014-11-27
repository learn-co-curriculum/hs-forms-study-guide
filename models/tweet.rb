class Tweet
  attr_accessor :name, :status

  ALL = []

  def initialize(name, status)
    @name = name
    @status = status
    ALL << self
  end

  def self.all
    ALL
  end
end