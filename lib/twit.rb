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
      parsed_line = line.chomp
      text = parsed_line =~ /\s/ ? parsed_line.gsub(' ', '_') : parsed_line
      hash[text.to_sym] = parsed_line
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
      search_term = "%22#{URI.escape(value)}%22"
      search_url = "http://search.twitter.com/search.json?q=#{search_term}&rpp=#{results_per_page}&page=#{page}&lang=en"
      resp = Net::HTTP.get_response(URI.parse(search_url))
      result = Oj.load(resp.body)
      if result.has_key? 'Error'
        raise "Error assessing tweet data"
      end
      new_hash[key] = result['results']
    end
    new_hash
  end

end