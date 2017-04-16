require "uri"
require "oga"
require "httparty"

class Spider
    MAX_URLS = 1000

    def initialize(options = {})
        @root = nil
        @max_urls = options.fetch(:max_urls, MAX_URLS)
    end

    def results(start_url)
        return [] if start_url.nil? or start_url.empty?

        @root = URI.parse(start_url)
        urls = [start_url]

        results = []
        while(urls.size > 0)
            url = urls.shift
            page = get_page(url)
            results << {url: url, assets: get_assets(page)}
            urls.concat get_child_urls(page)
        end

        results
    end

    private

    def normalize_url(url)
        uri = URI.parse(url)
        return uri if uri.absolute?
        URI.join(@root, url)
    end

    def get_page(url)
        response = HTTParty.get(url)
        Oga.parse_html(response.body)
    end

    def get_assets(page)
        return [] if page.nil?

        assets = []
        page.css('link').each do |l|
            next unless l['href']
            url = normalize_url(l['href'])
            assets << url.to_s if url.host == @root.host
        end

        page.css('script').each do |s|
            next unless s['src']
            url = normalize_url(s['src'])
            assets << url.to_s if url.host == @root.host
        end

        page.css('img').each do |i|
            next unless i['src']
            url = normalize_url(i['src'])
            assets << url.to_s if url.host == @root.host
        end

        assets
    end

    def get_child_urls(page)
        return [] if page.nil?

        urls = []
        page.css('a').each do |l|
            break if urls.size == @max_urls
            next unless l['href']
            url = normalize_url(l['href'])
            urls << url.to_s if url.host == @root.host
        end
        urls
    end
end
