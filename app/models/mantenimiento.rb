class Mantenimiento < ApplicationRecord

  def self.search(desde, hasta)
    puts Mantenimiento.where("fecha >= '#{desde}'").where("fecha <= '#{hasta}'")
  end
end
