class Hole < ActiveRecord::Base

  PAR_FACTOR = 4/5.to_f

  def par
    read_attribute :par or (length - ball_speed * PAR_FACTOR).to_i
  end

  # how easy the hole is
  # if it's long with a very low best, it's probably an easy hole
  def ball_speed
    length - best rescue 0
  end

end

class NullHole < OpenStruct
end
