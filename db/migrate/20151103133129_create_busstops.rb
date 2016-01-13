class CreateBusstops < ActiveRecord::Migration
  def change
    create_table :busstops, {id: false} do |t|
      t.integer :uid
      t.integer :code
      t.string :road
      t.string :desc
      t.float :lat
      t.float :long
      t.integer :zip

      t.timestamps
    end
  end
end
