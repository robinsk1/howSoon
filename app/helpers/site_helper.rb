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
   @tweets.each do |key, tweet|
     highlight =  highlight(tweet[:tweet][0]['text'].to_s, key.to_s.humanize.downcase)
     content << "example.footnote({
        start: #{tweet[:start]},
        end: #{tweet[:stop]},
        text: '#{escape_javascript(highlight)}',
        target: 'footnote'
      }); "
    end
    return content
  end


end
