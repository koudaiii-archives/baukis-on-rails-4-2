class Robot
  attr_accessor :name

  def initialize
    @name = "ROBOT"
  end
end

r = Robot.new
p r.name
