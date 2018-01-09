#!/usr/bin/env ruby

# organizing_committee =
# http://ekaw2016.cs.unibo.it/?q=organizing_committee
#
# http://www.cikmconference.org/organizers.html

def start
  puts '[INFO] PLACE text files under a folder named' +
        ' with the event title (eg. SAVE-SD2017)'
  puts '[INPUT] which event would you like to sanctify'
  event_title = gets.chomp
  event_files = Dir.entries(Dir.pwd + '/' + event_title) # list of files
  output_path = Dir.pwd + '/output/' # :TODO csv
  event_files.each do |event_file|
    next if (event_file == '.') || (event_file == '..') # skip these
    event_file = open(Dir.pwd + '/' + event_title + '/' + event_file)
    puts '[INPUT] what would you like to sanctify for openresearch? \
                D - Description
                I - Important Dates
                O - Organization Committee
                S - Submissions
                T - Topics'
    choice = gets.chomp
    case choice
    when 'd' || 'D'
      sanctify_description(event_file, event_title, output_path)
    when 'i' || 'I'
      sanctify_dates(event_file, event_title, output_path)
    when 'o' || 'O'
      sanctify_committee(event_file, event_title, output_path)
    when 't' || 'T'
      sanctify_topics(event_file, event_title, output_path)
    end
  end
end

def sanctify_description(event_file, event_title, output_path)
  # something
end

def sanctify_dates(event_file, event_title, output_path)
  # something
end

def sanctify_committee(event_file, event_title, output_path)
  # something
  collected_lines = []
  output_file = File.new(output_path + 'Organization' + '.txt', 'w') # create output file
  output_file.puts '==Committees=='
  # while (line = event_file.gets)
  #   puts line.inspect
  # end
  event_file_content = File.read(event_file)

  collected_lines << event_file_content.
                     match(/(Senior Program Committee\n(.+))+/)
  puts collected_lines
end

def sanctify_submissions(event_file, event_title, output_path)
  # something
end

def sanctify_topics(event_file, event_title, output_path)
  # something
end

start
