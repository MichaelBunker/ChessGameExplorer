class StudyController < ApplicationController

  def show

  end

  def index
    # client = MediawikiApi::Client.new "https://en.wikipedia.org/w/api.php?action=query&prop=revisions&rvprop=content&format=jsonfm&titles=chess&action=raw"
    # # response_parse = JSON.parse(client)
    # @result = client.get_wikitext("chess")
    # @words = @result

    @response = Wikipedia.find('Chess')

    binding.pry
  end

end
