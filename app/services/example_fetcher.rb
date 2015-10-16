class ExampleFetcher
  def self.perform(build_num:)
    base_url = "https://circleci.com/api/v1/project/#{ENV["CIRCLE_USERNAME"]}/#{ENV["CIRCLE_PROJECT"]}"
    vcs_revision = JSON.parse(Faraday.new.get("#{base_url}/#{build_num}?circle-token=#{ENV["CIRCLE_TOKEN"]}").body)["vcs_revision"]
    body = Faraday.new.get("#{base_url}/#{build_num}/tests?circle-token=#{ENV["CIRCLE_TOKEN"]}").body
    json = JSON.parse(body)
    examples = json["tests"]
    examples.each do |example|
      params = example.slice("file", "name", "run_time").merge(vcs_revision: vcs_revision)
      Example.create!(params)
    end
  end
end
