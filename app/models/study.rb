class Study < ActiveRecord::Base
  before_create :get_html


private
  def get_html
    request = RestClient.get 'https://en.wikipedia.org/w/api.php', :params => { :action => query, :titles => 'chess', :prop => revisions, :rvprop => content, :format => json }
    request_parse = JSON.parse(request)
  end

end
