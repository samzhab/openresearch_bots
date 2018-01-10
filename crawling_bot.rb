#!/usr/bin/env ruby
# require 'json'
require 'addressable'
require 'rest-client'
require 'nokogiri'
require 'csv'
#
# require 'webmock'
# include WebMock::API
#
# WebMock.enable!

# ----------------------------------------------------------------------------
# empty_response_file = File.new(Dir.pwd + '/web_mocks/portal.core.edu.au.empty.html')
# stub_request(:get, "http://portal.core.edu.au/conf-ranks/?by=all&page="\
#                    "1&search=ICPRAI&sort=atitle&source=CORE2018").
# to_return(body: empty_response_file, status: 200)
# # ----------------------------------------------------------------------------
# www_core_17_response_file = File.new(Dir.pwd + '/web_mocks/portal.core.edu.au.2017.html')
# stub_request(:get, "http://portal.core.edu.au/conf-ranks/?by=all&page="\
#                    "1&search=WWW&sort=atitle&source=CORE2017").
# to_return(body: www_core_17_response_file, status: 200)
# # ----------------------------------------------------------------------------
# www_core_18_response_file = File.new(Dir.pwd + '/web_mocks/portal.core.edu.au.2018.html')
# stub_request(:get, "http://portal.core.edu.au/conf-ranks/?by=all&page="\
#                    "1&search=WWW&sort=atitle&source=CORE2018").
# to_return(body: www_core_18_response_file, status: 200)
# ----------------------------------------------------------------------------

def start
  csv_files = Dir.entries(Dir.pwd + '/csv_files/') # list of csv files
  puts '[START] started extracting all events to separate csv file'
  core18_base = 'http://portal.core.edu.au/conf-ranks/?search='
  core18_trail = '&by=all&source=CORE2018&sort=atitle&page=1'
  core17_base = 'http://portal.core.edu.au/conf-ranks/?search='
  core17_trail = '&by=all&source=CORE2017&sort=atitle&page=1'
  csv_files.each do |csv_file_name|
    next if (csv_file_name == '.') || (csv_file_name == '..') # skip these
    csv_file    = Dir.pwd + '/csv_files/' + csv_file_name
    CSV.foreach(csv_file) do |row|
      event_series = row[0].split(' ')[0]
      core17_fomred_url = core17_base + event_series + core17_trail
      core18_fomred_url = core18_base + event_series + core18_trail
      core_2018_rank = crawl_core_17_ranking(core17_fomred_url)
      core_2017_rank = crawl_core_18_ranking(core18_fomred_url)
      if core_2018_rank
        puts core_2017_rank
        puts core_2018_rank
        puts '-/-/-//-/-/' + event_series
      end
      # do crawling for all csv files in folder here
    end
  end

end

def mock_crawl
  puts '[START] started extracting all events to separate csv file'
  core18_base = 'http://portal.core.edu.au/conf-ranks/?search='
  core18_trail = '&by=all&source=CORE2018&sort=atitle&page=1'
  core17_base = 'http://portal.core.edu.au/conf-ranks/?search='
  core17_trail = '&by=all&source=CORE2017&sort=atitle&page=1'
  event_series = 'WWW'
  # event_series = 'ICPRAI'
  core17_fomred_url = core17_base + event_series + core17_trail
  core18_fomred_url = core18_base + event_series + core18_trail
  core_2018_rank = crawl_core_17_ranking(core17_fomred_url)
  core_2017_rank = crawl_core_18_ranking(core18_fomred_url)
  puts core_2017_rank
end

def crawl_core_18_ranking(core18_fomred_url)
  begin
    response = RestClient::Request.execute(method: :get,
                                           url: Addressable::URI
                                             .parse(core18_fomred_url)
                                             .normalize.to_str,
                                           timeout: 5)
    doc = Nokogiri::HTML(response)
    rank_table = doc.at('table')
    if rank_table
      # puts rank_table.search('td.nowrap').text.split(' ')[2]
      core_2018_rank = rank_table.search('td.nowrap').text.split(' ')[2]
      # table tbody tr.evenrow td.nowrap
    end
#container.container_12.clearfix div.grid_12 div#search table
  rescue RestClient::ExceptionWithResponse => e
    puts e.response
  end
  core_2018_rank
end

def crawl_core_17_ranking(core17_fomred_url)
  begin
    response = RestClient::Request.execute(method: :get,
                                           url: Addressable::URI
                                             .parse(core17_fomred_url)
                                             .normalize.to_str,
                                           timeout: 5)
    doc = Nokogiri::HTML(response)
    rank_table = doc.at('table')
    if rank_table
      # puts rank_table.search('tr.evenrow').text.split(' ')[7]
      core_2017_rank = rank_table.search('td.nowrap').text.split(' ')[2]
      # table tbody tr.evenrow td.nowrap
    end
#container.container_12.clearfix div.grid_12 div#search table
  rescue RestClient::ExceptionWithResponse => e
    puts e.response
  end
  core_2017_rank
end

# mock_crawl
start

# ICPRAI
# http://portal.core.edu.au/conf-ranks/1548/
# http://portal.core.edu.au/conf-ranks/1548/

# ICMLC
# WWW
