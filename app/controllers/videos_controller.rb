class VideosController < ApplicationController
    def show
        # open the video file
        agent = Mechanize.new
        page = agent.get("https://www.youtube.com/watch?v=#{params[:id]}")
        title = page.title

        # remove the " - YouTube" from the title
        @title = title.gsub(" - YouTube", "")

        data = page.body.split(" ytInitialData = ")[1].split("</script>")[0][0..-2]
        json = JSON.parse(data)
        
        # get description
        @description = json['contents']['twoColumnWatchNextResults']['results']['results']['contents'][1]['videoSecondaryInfoRenderer']['attributedDescription']['content']
    end
end