class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
      t.text       :comment
      t.string     :status,  null: false

      t.references :reviewer, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true

      t.timestamps
    end
  end
end
