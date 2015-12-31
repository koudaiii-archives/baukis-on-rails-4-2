class Robot
  attr_writer :name

  def name
    @name ||= 'ROBOT'
  end
end

r = Robot.new
puts r.name
puts r.name = 'test'
