class SearchController < ApplicationController
    DEVELOPER_KEY = 'AIzaSyBhAjbjW-4w930JcwGKCYngkfr-he1vrks'
    YOUTUBE_API_SERVICE_NAME = 'youtube'
    YOUTUBE_API_VERSION = 'v3'
    API_ENDPOINT = "https://www.googleapis.com/#{YOUTUBE_API_SERVICE_NAME}/#{YOUTUBE_API_VERSION}/search"

    def search
        if params[:search_type] == 'videos'
            youtube_search_api(params[:q])
        elsif params[:search_type] == 'recipes'
            @recipes = Recipe.moderated.where('title LIKE ?', "%#{params[:q]}%")
            @recipes += Recipe.moderated.where('description LIKE ?', "%#{params[:q]}%")
            @recipes.uniq!
        else
            @recipes = []
        end
    end

    private

    def youtube_search_api(query)
        channels = Channel.all.pluck(:youtube_id)
        # Set up the request parameters
        query = "#{query} українською"
        params = {
            q: query,
            key: DEVELOPER_KEY,
            part: 'snippet',
            maxResults: 50 # You can adjust the number of results you want
        }
        # Build the URL
        uri = URI(API_ENDPOINT)
        uri.query = URI.encode_www_form(params)
        # Create an HTTP request
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        request = Net::HTTP::Get.new(uri)
        # Send the request and get the response
        response = http.request(request)

        @videos = []
        if response.code.to_i == 200
            data = JSON.parse(response.body)
            items = data['items']
            items.each do |item|
                channel_id = item['snippet']['channelId']
                next if !channels.include?(channel_id)
                @videos << {
                    video_id: item['id']['videoId'],
                    thumbnail_url: item['snippet']['thumbnails']['high']['url'],
                    title: item['snippet']['title'],
                    channel_id: item['snippet']['channelId']
                }
            end
        end
    end
end