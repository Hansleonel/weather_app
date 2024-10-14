import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/config/theme/app_theme.dart';
import 'package:weather_app/presentation/providers/weather_provider.dart';
import 'package:weather_app/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather App',
        theme: AppTheme(selectedColor: 5).theme(),
        home: const HomeScreen(),
      ),
    );
  }
}
