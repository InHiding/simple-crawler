require "spec_helper"

RSpec.describe Spider do
    subject { Spider.new }

    describe '#results' do
        let(:input) { 'http://www.example.com' }
        let(:output) { subject.results(input) }

        it "empty results for nil input" do
            expect(subject.results(nil)).to eq []
        end

        it "empty results for empty input" do
            expect(subject.results('')).to eq []
        end

        it "empty assets for valid empty page" do
            stub_request(:any, "www.example.com")
            expect(output).to eq [{:url=>"http://www.example.com", :assets=>[]}]
        end

        it "url list for valid page with relative link" do
            stub_request(:any, "www.example.com").
                to_return(body: '<html><a href="/about">About</a></html>')
            stub_request(:any, "www.example.com/about").to_return(body: "")

            expect(output).to eq [
                {:url=>"http://www.example.com", :assets=>[]},
                {:url=>"http://www.example.com/about", :assets=>[]}
            ]
        end

        it "url list for valid page with absolut link" do
            stub_request(:any, "www.example.com").
                to_return(body: '<html><a href="http://www.example.com/about">About</a></html>')
            stub_request(:any, "www.example.com/about").to_return(body: "")

            expect(output).to eq [
                {:url=>"http://www.example.com", :assets=>[]},
                {:url=>"http://www.example.com/about", :assets=>[]}
            ]
        end

        it "ignore subdomain urls" do
            stub_request(:any, "www.example.com").
                to_return(body: '<html><a href="http://another.example.com/page">Outside</a></html>')

            expect(output).to eq [{:url=>"http://www.example.com", :assets=>[]}]
        end

        it "ignore other domain urls" do
            stub_request(:any, "www.example.com").
                to_return(body: '<html><a href="http://www.google.com/">Google</a></html>')

            expect(output).to eq [{:url=>"http://www.example.com", :assets=>[]}]
        end

        it "assets for valid page with images" do
            stub_request(:any, "www.example.com").
                to_return(body: '<html><img src="/image.png"></html>')

            expect(output).to eq [{
                :url=>"http://www.example.com",
                :assets=>["http://www.example.com/image.png"]
            }]
        end

        it "ignore assets from subdomain urls" do
            stub_request(:any, "www.example.com").
                to_return(body: '<html><img src="http://cdn.example.com/image.jpg"></html>')

            expect(output).to eq [{:url=>"http://www.example.com", :assets=>[]}]
        end

        it "assets for valid page with css" do
            stub_request(:any, "www.example.com").
                to_return(body: '<html><head>i<link rel="stylesheet" type="text/css" href="mystyles.css"/></head></html>')

            expect(output).to eq [{
                :url=>"http://www.example.com",
                :assets=>["http://www.example.com/mystyles.css"]
            }]
        end
    end
end
