# frozen_string_literal: true

require 'delegate'

class Robot
  attr_reader :model_name, :id, :release_date
  def initialize(model_name:, id:, release_date:)
    @model_name = model_name
    @id = id
    @release_date = release_date
  end
end

class RobotFirstDecorator < SimpleDelegator
  def age
    ((Time.now - release_date) / 31557600).floor
  end
end

class RobotSecondDecorator < SimpleDelegator
  def full_name
    "#{id} => #{model_name}"
  end
end

robot = Robot.new(
  release_date: Time.new(2015, 3, 2, 3, 0, "+03:00"),
  id: "934kawrr22",
  model_name: "IOI"
)

robot_decorator = RobotFirstDecorator.new(robot)
robot_decorator = RobotSecondDecorator.new(robot_decorator)

puts robot_decorator.class
# RobotSecondDecorator
puts robot_decorator.id
# 934kawrr22
puts robot_decorator.model_name
# IOI
puts robot_decorator.full_name
# 934kawrr22 => IOI
puts robot_decorator.release_date
# 2015-03-02 03:00:03 +0300
puts robot_decorator.age
# 2
