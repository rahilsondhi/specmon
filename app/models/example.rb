class Example < ActiveRecord::Base
  validates :file, :name, :run_time, :vcs_revision, presence: true
end
