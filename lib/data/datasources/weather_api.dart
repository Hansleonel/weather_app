import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import '../cache/weather_cache.dart';

class WeatherApi {
  static const String apiKey = 'd9dc9ca003e3b64dd8b693bf3ca465b2';
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  final WeatherCache _cache;

  WeatherApi(this._cache);

  Future<Map<String, dynamic>> fetchWeather(String location) async {
    developer.log('Fetching weather for location: $location',
        name: 'WeatherApi');

    final cachedData = await _cache.getWeatherData(location);
    if (cachedData != null) {
      developer.log('CACHE HIT: Returning cached weather data for $location',
          name: 'WeatherApi');
      return cachedData;
    }

    developer.log('CACHE MISS: No valid cached data found for $location',
        name: 'WeatherApi');
    developer.log('Fetching fresh data from API for $location',
        name: 'WeatherApi');

    final Uri uri =
        Uri.parse('$baseUrl/weather?q=$location&units=metric&appid=$apiKey');
    developer.log('API request URL: $uri', name: 'WeatherApi');

    try {
      final response = await http.get(uri);

      developer.log('API Response status code: ${response.statusCode}',
          name: 'WeatherApi');
      developer.log('API Response body: ${response.body}', name: 'WeatherApi');

      if (response.statusCode == 200) {
        final weatherData = json.decode(response.body);
        await _cache.saveWeatherData(location, weatherData);
        developer.log(
            'Successfully fetched fresh data from API and cached for $location',
            name: 'WeatherApi');
        return weatherData;
      } else {
        developer.log(
            'Failed to fetch weather data from API. Status code: ${response.statusCode}',
            name: 'WeatherApi');
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      developer.log('Error fetching weather data from API: $e',
          name: 'WeatherApi', error: e);
      rethrow;
    }
  }
}
