require 'journey'

describe Journey do

  let(:my_journey){Journey.new}
  let(:entry_station_double){double("Shoreditch")}
  let(:exit_station_double){double("Barbican")}


  it 'can respond to start_journey method' do
    expect(my_journey).to respond_to(:start_journey).with(1).argument
  end

  it 'can store start station at journey beginning' do

    my_journey.start_journey(entry_station_double)
    expect(my_journey.entry_station).to eq(entry_station_double)
  end

  it 'can store exit station at journey ending' do
    my_journey.start_journey(entry_station_double)
    my_journey.end_journey(exit_station_double)

    expect(my_journey.exit_station).to eq(exit_station_double)
  end
end
