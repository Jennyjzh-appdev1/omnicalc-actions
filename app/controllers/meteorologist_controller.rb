require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather
    @street_address = params.fetch("user_street_address")
    sanitized_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A sanitized version of the street address, with spaces and other illegal
    #   characters removed, is in the string sanitized_street_address.
    # ==========================================================================

    sanitized_street_address = sanitized_street_address.gsub(",", "").gsub("%20", "+")
    url_coord = "https://maps.googleapis.com/maps/api/geocode/json?address=" + sanitized_street_address + "&key=AIzaSyA5qwIlcKjijP_Ptmv46mk4cCjuWhSzS78"
    parsed_data = JSON.parse(open(url_coord).read)
    
    
    @latitude = parsed_data.dig("results", 0, "geometry", "location", "lat").to_s
    @longitude = parsed_data.dig("results", 0, "geometry", "location", "lng").to_s
    
    url_weather = "https://api.darksky.net/forecast/8073cd3399ed8973d0113884e39aad16/" + @latitude + "," + @longitude
    
    @parsed_data = JSON.parse(open(url_weather).read)

   
    @current_temperature = @parsed_data.dig("currently", "temperature")

    @current_summary = @parsed_data.dig("currently", "summary")

    @summary_of_next_sixty_minutes = @parsed_data.dig("minutely", "summary")

    @summary_of_next_several_hours = @parsed_data.dig("hourly", "summary")

    @summary_of_next_several_days = @parsed_data.dig("daily", "summary")
    

    render("meteorologist_templates/street_to_weather.html.erb")
  end

  def street_to_weather_form
    render("meteorologist_templates/street_to_weather_form.html.erb")
  end
end
