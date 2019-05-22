require 'station'

describe Station do
  let(:my_station){Station.new("my stations name", "my stations zone")}
  it 'can be instantiated with 2 arguments' do
    expect(my_station.class).to eq(Station)
  end

  it 'can store my stations name' do
    expect(my_station.name).to eq("my stations name")
  end

  it 'can store my stations zone' do
    expect(my_station.zone).to eq( "my stations zone")
  end
end
