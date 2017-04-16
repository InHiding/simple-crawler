require "uri"
require "json"
require "simple_crawler/version"
require "simple_crawler/spider"

module SimpleCrawler
    INVALID_URL_ERROR = "Invalid URL URLs must start with 'http://' or 'https://'"

    def self.crawl(root='http://www.google.com')
        return JSON.pretty_generate({error: INVALID_URL_ERROR}) unless valid_url? root
        return JSON.pretty_generate crawler.results(root)
    end

    def self.valid_url?(url)
        return false if url.nil? or url.empty?

        uri = URI.parse(url)
        uri.kind_of?(URI::HTTP) or uri.kind_of?(URI::HTTPS)
    end
    private_class_method :valid_url?

    def self.crawler
        @spider ||= Spider.new
    end
end
