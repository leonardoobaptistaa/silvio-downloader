require 'spec_helper'

module SilvioDownloader
  describe 'Show' do
    describe '#new_with_description' do
      subject(:show) { Show.new_with_description(tvshow_description) }

      context 'with tv show name without spaces' do
        let(:tvshow_description) { 'dexter.s08e05.hd'}

        specify 'should create a tv show named dexter' do
          show.name.should eq 'Dexter'
        end

        specify 'should create a tv show with seasson 8' do
          show.seasson.should eq 8
        end

        specify 'should create a tv show with episode 5' do
          show.episode.should eq 5
        end

        specify 'should create a tv show in HD' do
          show.quality.should eq 'HD'
        end
      end

      context 'with tv show name with spaces' do
        let(:tvshow_description) { 'the.big.bang.theory.s04e22.sd'}

        specify 'should create a tv show named dexter' do
          show.name.should eq 'The Big Bang Theory'
        end

        specify 'should create a tv show with seasson 8' do
          show.seasson.should eq 4
        end

        specify 'should create a tv show with episode 5' do
          show.episode.should eq 22
        end

        specify 'should create a tv show in HD' do
          show.quality.should eq 'SD'
        end
      end
    end

    describe '#new' do
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

      it '#find_best_link get magnet link from best seeded torrent' do
        html_file = File.new('spec/htmls/thepiratebay.html')
        requested_link = 'http://thepiratebay.sx/search/Dexter%20S08E05%20720p/0/7/208'

        FakeWeb.register_uri(:get,
          requested_link,
          body: html_file.read,
          content_type: 'text/html'
        )

        subject.find_link(requested_link).should eq (
          'magnet:?xt=urn:btih:afeca4c382e3cf1029defe1bbd87ed9faaf84c0e&dn=Dexter+S08E04+720p+HDTV+x264-EVOLVE+%5Beztv%5D&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80&tr=udp%3A%2F%2Ftracker.publicbt.com%3A80&tr=udp%3A%2F%2Ftracker.istole.it%3A6969&tr=udp%3A%2F%2Ftracker.ccc.de%3A80&tr=udp%3A%2F%2Fopen.demonii.com%3A1337')
      end

      describe '#find_best_link_episode' do
        it "should call find_link with .org url and without 'sneak.peek' term" do
          subject.should_receive(:find_link).once.with(
            "http://thepiratebay.org/search/Dexter S08E05 720p -(sneak.peek) -(cocain)/0/7/208"
          )
          subject.find_best_link_episode
        end
      end

      describe '#find_best_link_seasson' do
        it "should call find_link with .org url and without 'sneak.peek' and 'cocain' terms" do
          subject.should_receive(:find_link).once.with(
            "http://thepiratebay.org/search/Dexter S09E01 720p -(sneak.peek) -(cocain)/0/7/208"
          )
          subject.find_best_link_seasson
        end
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
end