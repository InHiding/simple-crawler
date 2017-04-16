require "spec_helper"

RSpec.describe SimpleCrawler do
    it "has a version number" do
        expect(SimpleCrawler::VERSION).not_to be nil
    end

    it "check if urls are valid" do
        stub_request(:any, "www.example.org").
            to_return(body: '')

        expect(SimpleCrawler.crawl("http://www.example.org")).to eq(
            "[\n  {\n    \"url\": \"http://www.example.org\",\n    \"assets\": [\n\n    ]\n  }\n]"
        )
    end

    it "return error on invalid urls" do
        expect(SimpleCrawler.crawl("invalid.url")).to eq(
            "{\n  \"error\": \"Invalid URL URLs must start with 'http://' or 'https://'\"\n}"
        )
    end
end
