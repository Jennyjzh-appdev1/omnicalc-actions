require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather
    @lat = params.fetch("user_latitude").strip
    @lng = params.fetch("user_longitude").strip

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    url = "https://api.darksky.net/forecast/8073cd3399ed8973d0113884e39aad16/" + @lat + "," + @lng
    
    @parsed_data = JSON.parse(open(url).read)

    @current_temperature = @parsed_data.dig("currently", "temperature")

    @current_summary = @parsed_data.dig("currently", "summary")

    @summary_of_next_sixty_minutes = @parsed_data.dig("minutely", "summary")

    @summary_of_next_several_hours = @parsed_data.dig("hourly", "summary")

    @summary_of_next_several_days = @parsed_data.dig("daily", "summary")

    render("forecast_templates/coords_to_weather.html.erb")
  end

  def coords_to_weather_form
    render("forecast_templates/coords_to_weather_form.html.erb")
  end
  
end
