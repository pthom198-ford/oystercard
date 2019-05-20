#!/bin/env ruby
# encoding: utf-8

class Oystercard
  attr_reader :balance
  BALANCE_LIMIT = 90

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    raise "You can only top up maximum £90 on your oystercard" if amount > BALANCE_LIMIT
    if under_balance_limit(amount)
      @balance += amount
    else 
      raise "you can only have a maximum credit of £90"
    end
  end

  private

  def under_balance_limit(amount)
    (@balance + amount) < BALANCE_LIMIT
  end

end
