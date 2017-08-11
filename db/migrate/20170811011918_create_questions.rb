class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text    :content, null: false
      t.string  :source,  null: false
      t.integer :year,    null: false

      t.references :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
