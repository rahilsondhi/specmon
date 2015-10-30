class IndexVcsRevisionOnExamples < ActiveRecord::Migration
  def change
    add_index :examples, :vcs_revision
  end
end
