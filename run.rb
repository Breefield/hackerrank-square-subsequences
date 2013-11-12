class String
  # Does what it says, matches single characters in strings
  def matchCharacters(match, start=0, limit=nil)
    matches = []
    # look at each character and return it's index if it matches the match
    # TODO re-write this so it makes more sense :p
    (start..(self.length || limit)).each do |i|
      matches << i if match == self[i, 1]
    end
    matches
  end
    
  def scanForSquares(character, index, limit)
    matches = []
    # Get matching characters for the initial_character, ignore the initial_character
    # These individually represent square subsequences, however we are going to use them to "grow"
    # longer subsequences
    matching_indices = self.matchCharacters(character, index, limit)
    matching_indices.each { |o| puts "#{character}:" + (' '*(index-1)) + character + (' '*(o-index)) + character}

    # Example, if we have aabababaa
    # The index could be 0, i.e. "a"
    # Running the above will find the matches [1, 3, 5, 7, 8]

    # For each other "half" of the square's start i.e. [1, 3, 5, 7, 8]
    matching_indices.each do |i|

      matches << self[i]
      # This is where the recursing should happen
      # From index character + 1, until the matching half's index
      (index..i).each do |j|
        puts '-'
        self.scanForSquares(self[j], j+1, i)
      end
    end
    
    matches
  end

end

def testCase input
  matches = {}

  puts " :#{input}"

  input.length.times do |i|
    # puts input[i]
    #matches[input[i]] = 
    input.scanForSquares(input[i], i + 1, input.length)
    puts "-------------------"
    # puts
  end
end

test_cases = gets.strip.to_i

test_cases.times do
  testCase(gets.strip)
end