class ExamplesController < ApplicationController
  def index
    latest_vcs_revision = Example.last.vcs_revision
    @examples = Example.where(vcs_revision: latest_vcs_revision).order("run_time desc").all
  end
end
