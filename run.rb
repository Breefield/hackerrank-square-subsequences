class String
  # Does what it says, matches single characters in strings
  def matchCharacters(match, start=0)
    matches = []
    # look at each character and return it's index if it matches the match
    # TODO re-write this so it makes more sense :p
    (start..self.length).each do |i|
      matches << i if match == self[i, 1]
    end
    matches
  end

  def scanSquare(matches, character, left_start_index, right_start_index=nil)

    # matches = []
    # Get matching characters for the initial_character, ignore the initial_character
    # These individually represent square subsequences, however we are going to use them to "grow"
    # longer subsequences
    right_indices = self.matchCharacters(character, (right_start_index || left_start_index) + 1)

    # Example, if we have aabababaa
    # The left_start_index could be 0, i.e. "a"
    # Running the above will find the matches [1, 3, 5, 7, 8]

    # Right hand is empty
    if right_indices.empty?
      return matches
    end

    # For each other "half" of the square's start i.e. [1, 3, 5, 7, 8]
    right_indices.each do |right_index|
      # We didn't (but now do) have no right starts, in this case we wanna begin the subwalk
      if right_start_index.nil?
        # Recurse here? Omg omg omg
        (left_start_index..right_index).each do |left_index|
          matches << self.scanSquare(matches, self[left_index], left_start_index, right_index)
        end
      
      else
        left_index = left_start_index + 1 
        if left_index < right_start_index - 1
          return self.scanSquare(matches, self[left_index], left_index, right_index)
        else
          # Left hand is empty
          return character     
        end
      end

    end
    
    # matches
  end

end

def testCase input
  input.length.times do |i| 
    print input.scanSquare([], input[i], i)
    puts
  end
end

test_cases = gets.strip.to_i

test_cases.times do
  testCase(gets.strip)
end