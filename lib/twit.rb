require 'oj'
require 'net/http'
require 'uri'

class Twit

  attr_accessor :file

  def initialize(file)
    @file =  file
  end

  def load_file
    hash = Hash.new
    file = File.new(@file)
    while (line = file.gets)
      parsed_line = line.chomp.split("|")
      text = parsed_line[0] =~ /\s/ ? parsed_line[0].gsub(' ', '_') : parsed_line[0]
      nested = Hash.new
      nested[:text] = parsed_line[0]
      nested[:start] = ChronicDuration.parse(parsed_line[1])
      nested[:stop] = ChronicDuration.parse(parsed_line[2])
      hash[text.to_sym] = nested
    end
    file.close
    hash
  end

  def get_tweets
    results_per_page = 1
    page = 1
    new_hash = Hash.new
    hash = load_file
    hash.each do |key,value|
      nested = Hash.new
      search_term = "%22#{URI.escape(value[:text])}%22"
      search_url = "http://search.twitter.com/search.json?q=#{search_term}&rpp=#{results_per_page}&page=#{page}&lang=en"
      resp = Net::HTTP.get_response(URI.parse(search_url))
      result = Oj.load(resp.body)
      if result.has_key? 'Error'
        raise "Error assessing tweet data"
      end
      nested[:tweet] = result['results']
      nested[:start] = value[:start]
      nested[:stop] = value[:stop]
      new_hash[key] = nested
    end
    new_hash
  end

end