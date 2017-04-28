# Class Deck
class Deck
  
  SUITS = { diamonds: "<>", hearts: "<3", spades: ">8", clubs: "+" }
  PRIORITY = {
    "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, "9": 9, "10": 10,
    J: 10, Q: 10, K: 10, A: 11 
  }

attr_reader :cards

  def initialize
    @cards = []
    form
  end
  
  # private
  def form
    SUITS.each_value do | suit |
      PRIORITY.each do | par, coast |
        @cards << Card.new(suit, par, coast)
      end
    end
  end

  def shuffle_d!(n = 1)
    n.times{ @cards.shuffle! }
  end

end
