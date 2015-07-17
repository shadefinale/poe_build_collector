class CreateBuilds < ActiveRecord::Migration
  def change
    create_table :builds do |t|
      t.string :title
      t.string :url, :index => {unique: true}
      t.date :posted_date, :default => Time.now
      t.integer :replies, :default => 0
      t.integer :char
      t.references :author
      t.references :skill

      t.timestamps null: false
    end
  end

end
