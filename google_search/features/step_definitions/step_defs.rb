Given(/^I am at google home page$/) do
  @app.google_home.load
end

Given(/^I enter "(.*?)" into the search bar$/) do |text|
  @app.google_home.search_txt.set(text)
end

When(/^I hit search$/) do
  @app.google_home.search_btn.click
end

When(/^I get count and Ads url$/) do
  input_file = "C:\\Users\\nx81\\Documents\\input.csv"
  output_file = "C:\\Users\\nx81\\Documents\\output.csv"
  reader = CSV.open(input_file,'r')
  writer = CSV.open(output_file,'w')
  counter = reader.count
  reader.rewind
  i=0
  while i < counter do
    row = reader.shift
    if(i > 0)
    @app.google_home.search_txt.set(row[0].to_s)
    @app.google_home.search_btn.click
    @app.google_home.wait_for_ads(10)
    concat_ads=''
    @app.google_home.ads.each_with_index do |ads,i|
        concat_ads+=ads.text+'|'
    end
    row[1] = concat_ads.to_s
    row[2] = @app.google_home.ads.count
    writer.puts row
    end
    i = i+1
  end
  reader.close
  writer.close

end



Given(/^I search for youtube$/) do
  #!/usr/bin/ruby
 # require 'rubygems'
 # require 'google/api_client'
 # require 'trollop'
  # # Set DEVELOPER_KEY to the "API key" value from the "Access" tab of the
  # Google Developers Console <https://cloud.google.com/console>
  # Please ensure that you have enabled the YouTube Data API for your project.
  DEVELOPER_KEY = "AIzaSyCAgy4wtGT7inTWcpc6dHbQ5eAr57Y9_uo"
  YOUTUBE_API_SERVICE_NAME = "youtube"
  YOUTUBE_API_VERSION = "v3"

  opts = Trollop::options do
    opt :q, 'Search term', :type => String, :default => 'Google'
    opt :maxResults, 'Max results', :type => :int, :default => 25
  end

  client = Google::APIClient.new(:key => DEVELOPER_KEY,
                                 :authorization => nil)
  youtube = client.discovered_api(YOUTUBE_API_SERVICE_NAME, YOUTUBE_API_VERSION)

# Call the search.list method to retrieve results matching the specified
# query term.
  opts[:part] = 'id,snippet'
  search_response = client.execute!(
      :api_method => youtube.search.list,
      :parameters => opts
  )

  videos = []
  channels = []
  playlists = []

# Add each result to the appropriate list, and then display the lists of
# matching videos, channels, and playlists.
  search_response.data.items.each do |search_result|
    case search_result.id.kind
      when 'youtube#video'
        videos.push("#{search_result.snippet.title} (#{search_result.id.videoId})")
      when 'youtube#channel'
        channels.push("#{search_result.snippet.title} (#{search_result.id.channelId})")
      when 'youtube#playlist'
        playlists.push("#{search_result.snippet.title} (#{search_result.id.playlistId})")
    end
  end

  puts "Videos:\n", videos, "\n"
  puts "Channels:\n", channels, "\n"
  puts "Playlists:\n", playlists, "\n"
end