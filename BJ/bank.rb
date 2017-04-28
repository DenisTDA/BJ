# Class bank
class Bank
  BIT = 10
  attr_accessor :total

  def initialaze
    @total = 0
  end

  def take_bits(player)
    @total ||= 0
    @total += BIT
    player.bank -= BIT
  end

  def show
    puts "BANK = #{@bank}"
  end

  def draw(player1, player2)
    @total -=  BIT * 2
    player1.bank += BIT
    player2.bank += BIT
  end

  def take_win(player)
    player.bank += @total
    @total = 0
  end
end
