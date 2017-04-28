require_relative 'deck.rb'
require_relative 'card.rb'
require_relative 'player.rb'
require_relative 'bank.rb'
require_relative 'interface.rb'
require_relative 'game.rb'
require_relative 'validation.rb'

NAME = 'Croupier'.freeze

include Interface

bank = Bank.new
croup = Player.new(NAME)

Interface.intro

player_name = gets.chomp
player = Player.new(player_name)
deck = Deck.new
bank = Bank.new
game = Game.new(player, croup, deck, bank)

game.initial_game(player, croup)
loop do | |
  game.take_cards
  game.take_bit

  # game.choice_player
  unless game.overload
    if game.choice != '3'
      game.choice_croup
      game.choice_player
      game.overload
      game.open if game.choice != '3'
    end
  end
  game.result_part
  game.clear_part

  # player.bank = 100
  # croup.bank = 0
  next unless player.bank.zero? || croup.bank.zero?
  puts "\n\n GAME OVER!!! The winer is - "\
  "#{croup.bank < player.bank ? player.name : croup.name}"
  puts 'Do you wont play again? (y/n) :'
  yes_no = gets.chomp
  if yes_no == 'n'
    break
  else
    player.bank = Player::BANK
    croup.bank = Player::BANK
    system('cls')
  end
end
