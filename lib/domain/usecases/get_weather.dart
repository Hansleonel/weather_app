import 'package:weather_app/data/repositories/weather_repository.dart';
import 'package:weather_app/domain/entities/weather.dart';

class GetWeather {
  final WeatherRepository _repository = WeatherRepository();

  Future<Weather> execute(String location) async {
    return await _repository.getWeather(location);
  }
}
