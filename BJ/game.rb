# class Game
require_relative 'interface.rb'

class Game
  include Interface

  MENU = { '1': 'take_card',  '2': 'pass', '3': 'open' }

  attr_accessor :deck, :choice

  def initialize(player, croup, deck, bank)
    @player = player
    @croup = croup
    @deck = deck
    @bank = bank
    @options = { '1': 'take_card',  '2': 'pass', '3': 'open' }
  end

  def take_cards 
    @deck.shuffle_d!(3)
    2.times{ @player.take_card(@deck) }
    2.times{ @croup.take_card(@deck) }
  end 

  def take_bit
    @bank.take_bits(@player)
    @bank.take_bits(@croup)
    print_bank(@bank)
    show_player(@croup, @bank, :hide){@croup.calc_tow_cards}
    delimiter
    show_player(@player, @bank, :view){@player.calc_tow_cards}
    print_menu
    choice_player
  end

  def overload
    if @player.result > 21 
      print_overload
      player_win(@croup) 
    end
  end

  def pass(player)
    say_pass(player) 
    show_table(:hide)
    print_menu
  end

  def take_card(player)
    say_take_card(player) 
    player.take_card(@deck)
    player.add_points
    show_table(:hide)
    print_menu   
  end

  def choice_croup
    @croup.result < 18 ? take_card(@croup) : pass(@croup)
  end

  def open(*player)
    print_bank(@bank)
    show_table(:view)
  end

  def choice_player
    print "Your choice : "
    @choice = gets.chomp
    choice = @choice.to_sym
    raise 'Not right choice' unless @options[choice] == MENU[choice]
    self.send(@options[choice], @player)
    @options[choice] = 'Not avalible' 
  rescue => e
    print "#{e.inspect}"
  end

  def result_part
    if @player.result > @croup.result && @player.result < 22
      player_win(@player)  
    elsif @player.result < @croup.result && @croup.result < 22
      player_win(@croup)     
    elsif @player.result < 22 && @croup.result > 22
        player_win(@player) 
    elsif @player.result == @croup.result && @croup.result < 22
      print_deadheat
      @bank.draw(@player, @croup)
    end
  end

  def player_win(player)
      print_player_win(player)  
      @bank.take_win(player)
  end

  def clear_part
    @choice = ''
    @deck = Deck.new
    @player.onhands_off!
    @croup.onhands_off!
    @options = { '1': 'take_card',  '2': 'pass', '3': 'open' }
    puts "\n\nNew TOUR!!"
    puts "== * "*16 + "\n\n"
  end

  def show_table(status)
    show_player(@croup, @bank, status){}
    delimiter
    show_player(@player, @bank, :view){}     
  end
end