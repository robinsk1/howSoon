module SiteHelper

  def rocking
    @tweets.each do |key, tweet|
      highlight =  highlight(tweet[0]['text'].to_s, key.to_s.humanize.downcase)
      haml_tag(:div, highlight)
       haml_tag(:br)
     end
  end

  def tweets
    start = 1
    @tweets.each do |key, tweet|
      example.footnote({
        start: "#{start}",
        end: "#{start + 5}",
        text: highlight(tweet[0]['text'].to_s, key.to_s.humanize.downcase),
        target: "footnotediv"
      });
      -start += 5
    end
  end


end
