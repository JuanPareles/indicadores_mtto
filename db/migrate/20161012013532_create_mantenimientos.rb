class CreateMantenimientos < ActiveRecord::Migration[5.0]
  def change
    create_table :mantenimientos do |t|
      t.string :nro_mtto
      t.date :fecha
      t.string :equipo
      t.string :tipo
      t.integer :duracion
      t.integer :tiempo_aplicado
      t.text :observacion

      t.timestamps
    end
  end
end
