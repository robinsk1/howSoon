module SiteHelper

  def rocking
    @tweets.each do |key, tweet|
      highlight =  highlight(tweet[0]['text'].to_s, key.to_s.humanize.downcase)
      haml_tag(:div, highlight)
       haml_tag(:br)
     end
  end

  def escape_single_quotes
   self.gsub(/[']/, '\\\\\'')
  end

  def tweets_help
   content = ''
   start = 1
   @tweets.each do |key, tweet|
     highlight =  highlight(tweet[0]['text'].to_s, key.to_s.humanize.downcase)
     content << "example.footnote({
        start: #{start},
        end: #{start + 5},
        text: '#{escape_javascript(highlight)}',
        target: 'footnote'
      }); "
    start += 5
    end
    return content
  end


end
