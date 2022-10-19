# frozen_string_literal: true

class Player
  attr_reader :color, :id

  def initialize(id, color)
    @id = id
    @color = color
  end
end
