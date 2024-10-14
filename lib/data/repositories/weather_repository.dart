import 'package:weather_app/data/cache/weather_cache.dart';
import 'package:weather_app/data/datasources/weather_api.dart';
import 'package:weather_app/domain/entities/weather.dart';

class WeatherRepository {
  final WeatherApi _api = WeatherApi(WeatherCache());

  Future<Weather> getWeather(String location) async {
    final weatherData = await _api.fetchWeather(location);
    return Weather(
      location: weatherData['name'],
      temperature: weatherData['main']['temp'],
      humidity: weatherData['main']['humidity'],
      windSpeed: weatherData['wind']['speed'],
      condition: weatherData['weather'][0]['main'],
    );
  }
}
