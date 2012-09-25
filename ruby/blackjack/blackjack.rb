class Card
  attr_accessor :suit, :name, :value

  def initialize(suit, name, value)
    @suit, @name, @value = suit, name, value
  end

  def show
    puts "#{@name} of #{@suit}"
  end
end

class Deck
  attr_accessor :playable_cards
  SUITS = [:hearts, :diamonds, :spades, :clubs]
  NAME_VALUES = {
    :two   => 2,
    :three => 3,
    :four  => 4,
    :five  => 5,
    :six   => 6,
    :seven => 7,
    :eight => 8,
    :nine  => 9,
    :ten   => 10,
    :jack  => 10,
    :queen => 10,
    :king  => 10,
    :ace   => 11}

  def initialize
    shuffle
  end

  def deal_card(player)
    if remaining == 0
      shuffle
    end

    random = rand(@playable_cards.size)
    player.add(@playable_cards.fetch(random))
    @playable_cards.delete_at(random)
  end

  def shuffle
    @playable_cards = []
    SUITS.each do |suit|
      NAME_VALUES.each do |name, value|
        @playable_cards << Card.new(suit, name, value)
      end
    end
  end

  def remaining
    @playable_cards.length
  end
end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def show
    @cards.each do |card|
      card.show
    end
  end

  def add(card)
    @cards << card
  end

  def value
    ace_count = 0
    total = 0
    i = 0
    @cards.each do |card|
      if card.value == 11
        ace_count += 1
      end
      total += card.value
      while total > 21 and i < ace_count
        total -= 10
        i+=1
      end
    end
    total
  end

  def blackjack?
    (value == 21) & (@cards.length == 2)
  end

  def busted?
    value > 21
  end

  def size
    @cards.size
  end
end

class Player < Hand
  def display
    puts "Player's hand:"
    show
    puts "\nvalue: ", value, "\n"
  end
end

class Dealer < Hand
  def display
    puts "Dealer's hand:"
    show
    puts "\nvalue: ", value, "\n"
  end

  def display_top
    puts "Dealer is showing: "
    @cards.last.show
    puts "\n"
  end
end

class Game
  def initialize
    @deck = Deck.new
    @dealer = Dealer.new
    @player = Player.new
  end

  def reset_round
    @dealer = Dealer.new
    @player = Player.new
  end

  def play_round
    puts "New round of blackjack!\n\n"
    #dealing proceeds as if cards are real
    @deck.deal_card(@player)
    @deck.deal_card(@dealer)
    @deck.deal_card(@player)
    @deck.deal_card(@dealer)

    if @player.blackjack?
      winner = "Player"
    elsif @dealer.blackjack?
      winner = "Dealer"
    else
      @dealer.display_top
      @player.display
      puts "Press 'h' to hit or 's' to stay."
      input = gets.chomp
      while input != "s"
        if input == "h"
          @deck.deal_card(@player)
          @player.display
          if @player.busted?
            winner = "Dealer"
            break
          end
        end
        puts "Press 'h' to hit or 's' to stay."
        input = gets.chomp
      end
      while (@dealer.value < 17) && (winner != "Dealer") do
        @deck.deal_card(@dealer)
      end
      if @dealer.busted? || (@player.value > @dealer.value)
        winner = "Player"
      elsif @player.value == @dealer.value
        winner = "neither (push)"
      else
        winner = "Dealer"
      end
    end
    @player.display
    @dealer.display
    puts "The winner is ", winner

    reset_round
  end
end