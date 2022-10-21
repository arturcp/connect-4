# frozen_string_literal: true

class Player
  attr_reader :color, :id, :name

  def initialize(id, name, color)
    @color = color
    @id = id
    @name = name
  end
end
