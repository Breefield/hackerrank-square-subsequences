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
    
    def scanForSquares(index)
        matches = []
        # Get matching characters for the initial_character, ignore the initial_character
        matching_indices = self.matchCharacters(self[index], index+1)
        
        # Example, if we have aabababaa
        # The index could be 0, i.e. "a"
        # Running the above will find the matches [1, 3, 5, 7, 8]

        # For each other square(b) start i.e. [1, 3, 5, 7, 8]
        matching_indices.each do |i|
            # From init_character + 1, until the matching half's init
            (index + 1..i).each do |j|
                self[index+1, j].matchCharacters(self[j], j)
            end
        end
        
        # matches
    end

end

def testCase input
    matches = []
    input.length.times do |i|
        input.scanForSquares(i)
        # matches <<
    end
end

test_cases = gets.strip.to_i

test_cases.times do
    testCase(gets.strip)
end