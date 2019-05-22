class Station
  attr_reader :station_name, :station_zone

  def initialize(name, zone)
    @station_name = name
    @station_zone = zone
  end

  def name
    station_name
  end

  def zone
    station_zone
  end
end
