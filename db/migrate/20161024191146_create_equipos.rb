class CreateEquipos < ActiveRecord::Migration[5.0]
  def change
    create_table :equipos do |t|
      t.string :nombre
      t.integer :m1
      t.integer :m2
      t.integer :m3
      t.integer :m4

      t.timestamps
    end
  end
end
