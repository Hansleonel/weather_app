class Weather {
  final String location;
  final double temperature;
  final int humidity;
  final double windSpeed;
  final String condition;
  final bool isCelsius;

  Weather({
    required this.location,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.condition,
    this.isCelsius = true,
  });

  Weather copyWith({
    double? temperature,
    bool? isCelsius,
    int? humidity,
    double? windSpeed,
    String? condition,
  }) {
    return Weather(
      location: location,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
      windSpeed: windSpeed ?? this.windSpeed,
      condition: condition ?? this.condition,
      isCelsius: isCelsius ?? this.isCelsius,
    );
  }

  String get temperatureString =>
      '${temperature.toStringAsFixed(1)}°${isCelsius ? 'C' : 'F'}';
}
