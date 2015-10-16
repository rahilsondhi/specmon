class CreateExamples < ActiveRecord::Migration
  def change
    create_table :examples do |t|
      t.string :file
      t.string :name
      t.float :run_time
      t.string :vcs_revision
      t.timestamps
    end
  end
end
