class WordCountController < ApplicationController
  def word_count
    @text = params.fetch("user_text")
    @special_word = params.fetch("user_word")

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    
    @word_count = @text.split.count.to_s

    @character_count_with_spaces = @text.gsub(/[^a-z0-9\s]/i, "").length.to_s

    @character_count_without_spaces = @text.gsub(/\s+/, "").length.to_s

    @occurrences = @text.downcase.scan(@special_word.downcase).count.to_s

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count_templates/word_count.html.erb")
  end

  def word_count_form
    render("word_count_templates/word_count_form.html.erb")
  end
end
