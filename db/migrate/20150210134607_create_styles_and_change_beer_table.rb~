class CreateStylesAndChangeBeerTable < ActiveRecord::Migration
  def change
    
    create_table :styles do |t|
      t.text :description
      t.timestamps null: false
    end

    change_table :beers do |t|
      t.rename :style, :old_style_string
    end

    add_column :beers, :style_id, :integer
  end
end
