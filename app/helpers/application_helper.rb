module ApplicationHelper
	def fix_url(url)
		if url.starts_with?('http://') ||  url.starts_with?('https://') 
    	url
		else
			url = "http://#{url}"
  	end
	end

	def display_datetime(dt)
		dt.strftime("%m/%d/%Y 1:%M%P %Z")
	end

end
