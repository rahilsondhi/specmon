class IndexRunTimeOnExamples < ActiveRecord::Migration
  def change
    add_index :examples, :run_time
  end
end
