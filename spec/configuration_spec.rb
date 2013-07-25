require 'spec_helper'

module SilvioDownloader
  describe 'Configuration' do
    describe '#initialize' do

      context 'with all field in show configured' do
        subject {Configuration.new('spec/config/sample_config.json') }

        it 'should load right number tv shows' do
          subject.shows.count.should == 1
        end

        it 'should parse JSON to Shows object - name' do
          subject.shows.first.name.should == "Dexter"
        end

        it 'should parse JSON to Shows object - last episode' do
          subject.shows.first.episode.should == 4
        end

        it 'should parse JSON to Shows object - last seasson' do
          subject.shows.first.seasson.should == 8
        end

        it 'should parse JSON to Shows object - quality' do
          subject.shows.first.quality.should == "HD"
        end
      end

      context 'with only name field configured' do
        subject {Configuration.new('spec/config/configuration_min.json') }

        it 'should parse JSON to Shows object - last episode' do
          subject.shows.first.episode.should == 1
        end

        it 'should parse JSON to Shows object - last seasson' do
          subject.shows.first.seasson.should == 1
        end

        it 'should parse JSON to Shows object - quality' do
          subject.shows.first.quality.should == "HD"
        end
      end

      context 'with all options filled' do  
        subject {Configuration.new('spec/config/sample_config.json') }

        it 'should parse JSON, hour interval' do
          subject.hour_interval.should == 2
        end

        it 'should parse download_path' do
          subject.download_path.should eq '~/Downloads'
        end

        it 'should parse transmission_host' do
          subject.transmission_host.should eq '192.168.1.99'
        end

        it 'should parse transmission port' do
          subject.transmission_port.should eq '9091'
        end

        it 'should parse transmission_user' do
          subject.transmission_user.should eq 'user'
        end

        it 'should parse transmission_password' do
          subject.transmission_password.should eq 'transmission'
        end
      end

      context 'with hour_interval not filled' do  
        subject {Configuration.new('spec/config/configuration_min.json') }

        it 'should parse JSON, hour interval' do
          subject.hour_interval.should == 1
        end
      end

    end
  end
end