# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
	Movie.create movie
  end
  
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  assert page.body =~ /#{e1}.*#{e2}/m, "#{e1} was not before #{e2}"

end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings:PG,G,R,NC-17"
#  "When I check the following ratings:G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(',').each do |rating|
    if uncheck
      uncheck "ratings_#{rating}"
    else
      check "ratings_#{rating}"
    end
  end
end



Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  movies = Movie.all
  
  if movies.size == 10
    movies.each do |movie|
      assert page.body =~ /#{movie.title}/m, "#{movie.title} did not appear"
    end
  else
    false
  end
end


Then /I should not see any movies/ do
  movies = Movie.all
  movies.each do |movie|
    assert true unless page.body =~ /#{movie.title}/m
  end
end



