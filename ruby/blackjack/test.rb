  require 'test/unit'
  require './blackjack.rb'

  class CardTest < Test::Unit::TestCase
    def setup
      @card = Card.new(:hearts, :ten, 10)
    end

    def test_card_suite_is_correct
      assert_equal @card.suit, :hearts
    end

    def test_card_name_is_correct
      assert_equal @card.name, :ten
    end
    def test_card_value_is_correct
      assert_equal @card.value, 10
    end
  end

  class DeckTest < Test::Unit::TestCase
    def setup
      @deck = Deck.new
      @player = Player.new
    end

    def test_new_deck_has_52_playable_cards
      assert_equal @deck.playable_cards.size, 52
    end

    def test_dealt_card_should_not_be_included_in_playable_cards
      card = @deck.deal_card(@player)
      assert(!@deck.playable_cards.include?(card))
    end

    def test_shuffled_deck_has_52_playable_cards
      @deck.shuffle
      assert_equal @deck.playable_cards.size, 52
    end
  end

  class HandTest < Test::Unit::TestCase
    def setup
      @ten = Card.new(:hearts, :ten, 10)
      @eight = Card.new(:hearts, :eight, 8)
      @seven = Card.new(:hearts, :seven, 7)
      @four = Card.new(:hearts, :four, 4)
      @ace = Card.new(:hearts, :ace, 11)
      @hand = Hand.new
    end

    def test_blackjack_true
      @hand.add(@ten)
      @hand.add(@ace)
      assert @hand.blackjack?
    end
    def test_blackjack_false_too_many_cards #blackjack can only be achieved with your first 2 cards
      @hand.add(@ten)
      @hand.add(@seven)
      @hand.add(@four)
      assert !@hand.blackjack?
    end
    def test_blackjack_false_not_21
      @hand.add(@ten)
      @hand.add(@four)
      assert !@hand.blackjack?
    end

    def test_busted_true
      @hand.add(@ten)
      @hand.add(@eight)
      @hand.add(@seven)
      assert @hand.busted?
    end
    def test_busted_false
      @hand.add(@ten)
      @hand.add(@four)
      assert !@hand.busted?
    end

    def test_value
      @hand.add(@eight)
      assert_equal @hand.value, 8
      @hand.add(@ace)
      assert_equal @hand.value, 19
      @hand.add(@ace)
      assert_equal @hand.value, 20
      @hand.add(@eight)
      assert_equal @hand.value, 18
      @hand.add(@eight)
      assert_equal @hand.value, 26
    end
  end