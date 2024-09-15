# In this file we define the methods to help filter out candidates
# This way, we keep these methods separated from other potential parts of the program
require 'active_support/all'
require './candidates'

  def find(id)
    for candidate in @candidates do
      if candidate[:id] == id
        return candidate
      end
    end
  end
  
  def experienced?(candidate)
    candidate[:years_of_experience] >= 2 ? true : false
    #id 5, 9, 10, 11, 13
  end
  
  def qualified_candidates(candidates)

    candidates.select do |candidate| 
      experienced?(candidate) &&
      github_points_system?(candidate) && # >= 100 points
      knows_ruby_or_python?(candidate) && 
      applied_in_the_last_15_days?(candidate) &&
      at_least_18(candidate)
    end

  end 

  def order_by_qualifications (candidates)
    # Candidates with the most experience are at the top
    # For Candidates that have the same years of experience, they are further sorted by their number of Github points (highest first)
    candidates.sort_by { |candidate| [candidate[:years_of_experience], -candidate[:github_points]] }

  end

  # Other Helper Methods
  def github_points_system?(candidate)
    candidate[:github_points] >= 100
    #id 5, 7, 9, 10, 13, 15
  end

  def knows_ruby_or_python?(candidate)
    candidate[:languages].include?('Ruby') && candidate[:languages].include?('Python')
    # id 5, 13
  end

  def applied_in_the_last_15_days?(candidate)
    candidate[:date_applied] >= 15.days.ago.to_date
    #id 5, 7, 9, 10, 11, 13, 15
  end

  def at_least_18(candidate)
    candidate[:age] >= 18
    #id 5, 7, 9, 10, 11, 13,
  end


  # pp find(13)
  # pp qualified_candidates(@candidates)
  pp order_by_qualifications(@candidates)


  
  