# Class Card
class Card
  attr_reader :suit, :par, :coast

  def initialize(suit, par, coast)
    @suit = suit
    @par = par
    @coast = coast
    @front_side = false
    graphic_binding
  end

  def name
    @name = @par.to_s + @suit.to_s
  end

  def show
    print "[**]\t" if !see?
    print "[#{self.name}]  " if see? 
  end

   def back_side!
    @front_side = false
  end

  def front_side!
    @front_side = true
  end

  private  
  def graphic_binding
  end

  def see?
    @front_side? true : false
  end

end
