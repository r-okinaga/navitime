class CreateNaviBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :navi_brands do |t|
      t.string :name
      t.string :provider_name
      t.string :store_name
      t.string :category_name
      t.integer :tel_no
      t.integer :postal_code
      t.string :address
      t.date :open_at

      t.timestamps
    end
  end
end
