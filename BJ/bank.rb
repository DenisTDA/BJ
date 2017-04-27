# Class bank
class Bank
  BIT = 10
attr_accessor :total

  def initialaze 
    @total = 0
  end

  def take_bits(player)
    @total+=  BIT
    player.total -= BIT
  end

  def show
    puts "BANK = #{@bank}"
  end

  def draw(player)
    @total -=  BIT
    player.bank += BIT
  end

  def take_win(player)
    pla.bank += @total
    @total = 0 
  end
end
