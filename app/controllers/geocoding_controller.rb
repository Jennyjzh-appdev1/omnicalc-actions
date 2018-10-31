require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords
    @street_address = params.fetch("user_street_address")
    sanitized_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A sanitized version of the street address, with spaces and other illegal
    #   characters removed, is in the string sanitized_street_address.
    # ==========================================================================

    sanitized_street_address = sanitized_street_address.gsub(",", "").gsub("%20", "+")
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + sanitized_street_address + "&key=AIzaSyA5qwIlcKjijP_Ptmv46mk4cCjuWhSzS78"
    
    parsed_data = JSON.parse(open(url).read)
    
    
    @latitude = parsed_data.dig("results", 0, "geometry", "location", "lat")
    @longitude = parsed_data.dig("results", 0, "geometry", "location", "lng")
    
    

    render("geocoding_templates/street_to_coords.html.erb")
  end

  def street_to_coords_form
    render("geocoding_templates/street_to_coords_form.html.erb")
  end
end
