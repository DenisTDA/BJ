# Module Interfase
module Interface
  def intro
    system('clear')
    puts "You'r wellcome on the BlackJack!"
    print 'For Start the game enter your Name: '
  end

  def initial_game(player, croup)
    puts "#{player.name}, your opponent is #{croup.name}"
  end

  def delimiter
    puts "\n" + '- - ' * 20 + "\n"
  end

  def print_bank(bank)
    puts "BANK = #{bank.total}"
  end

  def show_player(player, _bank, status)
    status_cards = { hide: 'back_side!', view: 'front_side!' }
    puts "**** #{player.name} ****"
    player.status_cards(status_cards[status])
    player.show_cards
    yield
    print "\tPoints = #{player.result}" if status == :view
    player.show_bank
  end

  def print_menu
    puts "\n\n1 - #{@options[:'1']}\t\t2 -"\
    " #{@options[:'2']}\t\t3 - #{@options[:'3']}"
  end

  def say_pass(player1)
    puts "\n#{player1.name} pass!"
  end

  def say_take_card(player)
    puts "\n#{player.name} taking card"
  end

  def print_player_win(player)
    puts "\n#{player.name} win!!!"
  end

  def print_deadheat
    puts "\nPoints equil! Dead Heat!"
  end

  def print_overload
    puts "\nOverload!!! #{@player.name} loose!"
  end
end
