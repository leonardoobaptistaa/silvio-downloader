require 'spec_helper'

module SilvioDownloader
  describe 'Show' do

    subject { 
      Show.new.tap do |show|
        show.name = name
        show.quality = quality
        show.episode = episode
        show.seasson = seasson
      end
    }

    let(:name)    { "Dexter" }
    let(:quality) { "HD" }
    let(:episode) { 4 }
    let(:seasson) { 8 }
  
    it '#next_episode_name get next episode' do
      subject.next_episode_name.should == "Dexter S08E05 720p"
    end

    it '#next_seasson_name get next seasson episode' do
      subject.next_seasson_name.should == "Dexter S09E01 720p"
    end

    it '#to_s get next seasson episode' do
      subject.to_s.should == "Dexter S08E04 720p"
    end

    xit '#find_best_link get magnet link from best seeded torrent' do
      html_file = File.new('spec/htmls/thepiratebay.html')
      requested_link = 'http://thepiratebay.sx/search/Dexter S08E05 720p/0/7/208'

      stub_request(:any, requested_link).to_return(:body => html_file, :status => 200)
      
      subject.find_best_link.should eq 
      'magnet:?xt=urn:btih:afeca4c382e3cf1029defe1bbd87ed9faaf84c0e&dn=Dexter+S08E04+720p+HDTV+x264-EVOLVE+%5Beztv%5D&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80&tr=udp%3A%2F%2Ftracker.publicbt.com%3A80&tr=udp%3A%2F%2Ftracker.istole.it%3A6969&tr=udp%3A%2F%2Ftracker.ccc.de%3A80&tr=udp%3A%2F%2Fopen.demonii.com%3A1337'
    end

    describe '#update_to_next_seasson' do
      before do
        subject.update_to_next_seasson
      end

      it 'add 1 to seasson' do
        subject.seasson.should eq 9
      end

      it 'put episode back to 1' do
        subject.episode.should eq 1
      end
    end

    describe '#update_to_next_episode' do
      before do
        subject.update_to_next_episode
      end

      it 'add 1 to episode' do
        subject.episode.should eq 5
      end
    end

  end
end