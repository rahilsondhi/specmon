class IndexVcsRevisionAndRunTimeOnExamples < ActiveRecord::Migration
  def change
    add_index :examples, [:vcs_revision, :run_time]
  end
end
