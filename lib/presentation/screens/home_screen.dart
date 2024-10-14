import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/presentation/providers/weather_provider.dart';
import 'package:weather_app/presentation/widgets/weather_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadInitialLocation();
  }

  Future<void> _loadInitialLocation() async {
    final weatherProvider =
        Provider.of<WeatherProvider>(context, listen: false);
    final location = await weatherProvider.getCurrentLocation();

    weatherProvider.fetchWeather(location);
  }

  void _performSearch() {
    if (_locationController.text.isNotEmpty) {
      Provider.of<WeatherProvider>(context, listen: false)
          .fetchWeather(_locationController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              final provider =
                  Provider.of<WeatherProvider>(context, listen: false);
              provider.fetchWeather(provider.weather?.location ?? 'Sidney');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: _locationController,
                        decoration: InputDecoration(
                          labelText: 'Enter location',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: _performSearch,
                          ),
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                        ),
                        onSubmitted: (_) => _performSearch(),
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Consumer<WeatherProvider>(
                        builder: (context, weatherProvider, child) {
                          if (weatherProvider.isLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (weatherProvider.error != null) {
                            return Center(child: Text(weatherProvider.error!));
                          } else if (weatherProvider.weather != null) {
                            return WeatherDisplay(
                                weather: weatherProvider.weather!);
                          } else {
                            return const Center(
                                child: Text('No weather data available'));
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
