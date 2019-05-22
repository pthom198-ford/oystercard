#!/bin/env ruby
# encoding: utf-8

require 'oystercard.rb'

describe Oystercard do
let(:card) {Oystercard.new}
let(:station_double) { double('station double', station_name: "Barbican") }
let(:station_exit_double) { double('station exit double', station_name: "Euston") }
let(:journey_double) {double("my_journey")}

  it "can create an instance of it self with default balance of 0" do
    expect(card.balance).to eql(0)
  end

  it 'has the ability to top up' do
    card.top_up(10)
    expect(card.balance).to eql(10)
  end

  it "will not top up over maximum limit of £90" do
    card.top_up(50)
    expect {card.top_up(50)}. to raise_error "you can only have a maximum credit of £90"
  end

  it 'can initialize card journey status as false' do
    expect(card.in_journey?).to eql (false)
  end

  it 'can touch in and start journey' do
    card.top_up(Oystercard::MINIMUM_BALANCE)
    allow(journey_double).to receive(:start_journey)
    card.touch_in(station_double, journey_double)

    expect(card.current_journey).to eql(journey_double)
  end

  it 'can touch out and end journey' do
    card.top_up(Oystercard::MINIMUM_BALANCE)
    allow(journey_double).to receive(:start_journey)
    card.touch_in(station_double, journey_double)

    allow(journey_double).to receive(:end_journey)
    card.touch_out(station_exit_double, journey_double)
    expect(card.current_journey).to eql(nil)
  end

  it 'will raise an error if card touches in with less than minimum fare' do
    expect { card.touch_in(station_double, journey_double) }.to raise_error 'Card does not have minumum fare loaded!'
  end

  it "will reduce balance once card is touched out" do
    card.top_up(Oystercard::MINIMUM_FARE)
    allow(journey_double).to receive(:start_journey)
    card.touch_in(station_double, journey_double)
    allow(journey_double).to receive(:end_journey)
    expect { card.touch_out(station_exit_double, journey_double) }.to change{ card.balance }.by ( - Oystercard::MINIMUM_FARE)
  end

  it 'will have an empty list of journeys by default' do
    expect(card.journeys).to eql([])
  end

  it "touching in and out will create one journey" do
    card.top_up(Oystercard::MINIMUM_FARE)
    allow(journey_double).to receive(:start_journey)
    card.touch_in(station_double, journey_double)
    allow(journey_double).to receive(:end_journey)
    card.touch_out(station_exit_double, journey_double)
    expect(card.journeys).to eql([journey_double])
  end
end
