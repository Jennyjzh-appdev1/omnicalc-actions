class StatsController < ApplicationController
  def stats
    @numbers = params.fetch("list_of_numbers").gsub(",", "").split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort
    @count = @numbers.count

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[@count-1]

    @range = @maximum - @minimum

    @median = (@sorted_numbers[(@count - 1) / 2] + @sorted_numbers[@count / 2]) / 2

    @sum = @numbers.sum

    @mean = @numbers.sum/@count
    
        sqdiff = []
        @numbers.each do |n|
          diff = n - @mean
          squared = diff * diff
          sqdiff.push(squared)
        end
  
    @variance = sqdiff.sum / sqdiff.count

    @standard_deviation = @variance**0.5
    
    # Mode
    # ====

        maxcount = 0
        mode = 0
        
        @numbers.each do |n|
          if @numbers.count(n) > maxcount
            maxcount = @numbers.count(n)
            mode = n
          end
        end
        
        if maxcount == 1
          mode = "no mode"
        end
  
    @mode = mode

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("stats_templates/stats.html.erb")
  end

  def stats_form
    render("stats_templates/stats_form.html.erb")
  end
  
end
