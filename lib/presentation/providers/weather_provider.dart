import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/usecases/get_weather.dart';

class WeatherProvider extends ChangeNotifier {
  final GetWeather _getWeather = GetWeather();

  Weather? _weather;
  String? _error;
  bool _isLoading = false;

  Weather? get weather => _weather;
  String? get error => _error;
  bool get isLoading => _isLoading;

  Future<void> fetchWeather(String location) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _weather = await _getWeather.execute(location);
      print('Weather data fetched >>>>> ${_weather?.condition}');
      getWeatherConditionLottie(_weather?.condition);
      _error = null;
    } catch (e) {
      _weather = null;
      _error = 'Failed to fetch weather data. Please try again.';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<String> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    String city = placemarks[0].locality ?? 'Unknown Location';
    return city;
  }

  void toggleTemperatureUnit() {
    if (_weather != null) {
      double newTemperature;
      if (_weather!.isCelsius) {
        newTemperature = celsiusToFahrenheit(_weather!.temperature);
      } else {
        newTemperature = fahrenheitToCelsius(_weather!.temperature);
      }

      _weather = _weather!.copyWith(
        isCelsius: !_weather!.isCelsius,
        temperature: newTemperature,
      );
      notifyListeners();
    }
  }

  double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }

  double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  String getWeatherConditionLottie(String? condition) {
    switch (condition) {
      case 'Clouds':
        return 'assets/cloud.json';
      case 'Mist':
      case 'Haze':
      case 'Fog':
      case 'Dust':
      case 'Smoke':
        return 'assets/cloud.json';
      case 'Rain':
      case 'Drizzle':
      case 'Shower Rain':
        return 'assets/rain.json';
      case 'Thunderstorm':
        return 'assets/thunder.json';
      case 'Snow':
        return 'assets/snow.json';
      case 'Clear':
        return 'assets/sun.json';
      default:
        return 'assets/sun.json';
    }
  }
}
