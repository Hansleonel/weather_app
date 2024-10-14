import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/presentation/providers/weather_provider.dart';

class WeatherDisplay extends StatelessWidget {
  final Weather weather;

  const WeatherDisplay({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            weather.location,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          Text(
            weather.temperatureString,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 10),
          Lottie.asset(
            Provider.of<WeatherProvider>(context, listen: false)
                .getWeatherConditionLottie(weather.condition),
          ),
          Text(
            weather.condition,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          Text('Humidity: ${weather.humidity}%'),
          Text('Wind Speed: ${weather.windSpeed} m/s'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Provider.of<WeatherProvider>(context, listen: false)
                  .toggleTemperatureUnit();
            },
            child: Text(
                'Switch to ${weather.isCelsius ? 'Fahrenheit' : 'Celsius'}'),
          ),
        ],
      ),
    );
  }
}
