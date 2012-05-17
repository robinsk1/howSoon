class SiteController < ApplicationController
 require 'Twit'
 layout false, :except => :index
 before_filter :js_content_type, :only => [:js_content_type, :tweets]

  def js_content_type
    response.headers['Content-type'] = 'text/javascript; charset=utf-8'
  end

  def index
  end

  def tweets
    lyrics = Twit.new("#{Rails.root}/lib/lyrics_cut.txt")
    @tweets = lyrics.get_tweets
    respond_to do |format|
        format.html {render :partial => 'tweets'}
      end
  end

end
