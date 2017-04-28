# class Player
require_relative 'validation.rb'

class Player
  include Validation

  BANK = 100
  A = 11
  BJ = 21
  NAME_FORMAT = /^[a-zA-Z]{1,20}$/

  attr_reader :result, :name, :onhands
  attr_accessor :bank, :pass
  validate :name, :format, NAME_FORMAT

  def initialize(name)
    @name = name.capitalize
    @onhands = []
    @bank = BANK
    @points = { min: 0, max: 0 }
    validate!
  end

  def take_card(deck)
    @onhands << deck.cards.pop
  end

  def status_cards(command)
    @onhands.each { |card| card.send(command) }
  end

  def onhands_off!
    @onhands = []
    @points = { min: 0, max: 0 }
  end

  def show_cards
    @onhands.each(&:show)
  end

  def calc_tow_cards
    points_tmp = 0
    @onhands.each { |card| points_tmp += card.coast }
    if points_tmp == BJ
      save_points!(21, 21)
    elsif points_tmp == A + A
      save_points!(2, 12)
    elsif @onhands.detect { |card| card.par == :A }
      save_points!(points_tmp - 10, points_tmp)
    else
      save_points!(points_tmp)
    end
    @points[:max] > BJ ? result!(@points[:min]) : result!(@points[:max])
  end

  def add_points
    points_tmp = @onhands.last.coast
    if points_tmp == A
      result = []
      @points.each do |_key, sum|
        result << sum + A << sum + 1
      end
      result.sort!
      result.reverse_each { |sum| result.pop if sum > BJ }
      result.any? ? result!(result.last) : result!(@points[min] + 1)
    else
      save_points!(points_tmp)
      @points[:max] > BJ ? result!(@points[:min]) : result!(@points[:max])
    end
  end

  def show_bank
    print "\tBank #{@name} = #{@bank}"
  end

  private

  def save_points!(min, max = min)
    @points[:min] += min
    @points[:max] += max
  end

  def result!(result)
    @result = result
  end
end
