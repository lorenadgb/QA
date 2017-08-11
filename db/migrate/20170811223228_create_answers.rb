class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text       :content, null: false
      t.boolean    :correct

      t.references :question, index: true, foreign_key: true

      t.timestamps
    end
  end
end
