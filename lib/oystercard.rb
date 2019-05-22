#!/bin/env ruby
# encoding: utf-8

class Oystercard
  attr_accessor :balance
  attr_reader :entry_station, :journeys, :current_journey
  BALANCE_LIMIT = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize(balance = 0)
    @balance = balance
    @journeys = []
    @current_journey = nil
  end

  def top_up(amount)
    raise "you can only have a maximum credit of £#{BALANCE_LIMIT}" if over_balance_limit?(amount)
    self.balance += amount  #self = oystercard.balance
  end


  def touch_in(entry_station, journey)
    raise 'Card does not have minumum fare loaded!' if balance < MINIMUM_BALANCE
    if !@current_journey.nil?
      deduct(PENALTY_FARE)
      @journeys.push(@current_journey)
    end
    @current_journey = journey
    @current_journey.start_journey(entry_station)
  end

  def touch_out(exit_station, journey)
    if @current_journey.nil?
      deduct(PENALTY_FARE)
      @current_journey = journey
    else
      deduct(MINIMUM_FARE)
    end

    @current_journey.end_journey(exit_station)
    @journeys.push(@current_journey)
    @current_journey = nil
  end

  def in_journey?
    !entry_station.nil?
  end

  private

  def over_balance_limit?(amount)
    (@balance + amount) > BALANCE_LIMIT
  end

  def deduct(amount)
    @balance -= amount
  end
end
