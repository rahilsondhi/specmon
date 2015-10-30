class ExampleFetcher
  BASE_URL = "https://circleci.com/api/v1/project/#{ENV["CIRCLE_USERNAME"]}/#{ENV["CIRCLE_PROJECT"]}"

  def self.create_examples_from_build(build_num:)
    vcs_revision = JSON.parse(Faraday.new.get("#{BASE_URL}/#{build_num}?circle-token=#{ENV["CIRCLE_TOKEN"]}").body)["vcs_revision"]
    body = Faraday.new.get("#{BASE_URL}/#{build_num}/tests?circle-token=#{ENV["CIRCLE_TOKEN"]}").body
    json = JSON.parse(body)
    examples = json["tests"]
    examples.each do |example|
      params = example.slice("file", "name", "run_time").merge(vcs_revision: vcs_revision)
      Example.create!(params)
    end
  end

  def self.recent_builds
    existing_builds = Example.distinct.select(:vcs_revision).pluck(:vcs_revision).inject({}) { |memo, vcs_revision| memo[vcs_revision] = nil; memo }
    body = Faraday.new.get("#{BASE_URL}/tree/#{ENV["CIRCLE_BRANCH"]}?circle-token=#{ENV["CIRCLE_TOKEN"]}").body
    recent_successful_builds = JSON.parse(body).select { |build| ["success", "fixed"].include?(build["status"]) }
    recent_successful_builds.each do |build|
      unless existing_builds.key?(build["vcs_revision"])
        create_examples_from_build(build_num: build["build_num"])
      end
    end
  end
end
