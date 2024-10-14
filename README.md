# Weather App

## Description

This is a weather forecast application developed with Flutter by HansLeonel. It allows users to obtain up-to-date weather information for different locations. The app uses the OpenWeatherMap API to fetch real-time data and offers the following features:

- Current location in real-time.
- Weather forecast search by location.
- Display of current temperature, weather conditions, humidity, and wind speed
- Lottie animations to visually represent weather conditions
- Option to switch between temperature units (Celsius/Fahrenheit)
- Local caching of weather data to reduce API calls

## Note on API Key

**Important**: For demonstration purposes, the OpenWeatherMap API key has been left visible in the source code (`lib/data/datasources/weather_api.dart`). In a production environment, this practice is not secure and is not recommended.

For proper use in production:

1. Create a `.env` file in the project root.
2. Store your API key in this file:
   ```
   OPENWEATHERMAP_API_KEY=your_api_key_here
   ```
3. Use a package like `flutter_dotenv` to securely load the API key into the application.
4. Make sure to add `.env` to your `.gitignore` file to avoid accidentally sharing your API key.

## Installation and Running

1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. Ensure you have an emulator running or a device connected
4. Run `flutter run` to start the application

https://github.com/user-attachments/assets/287850d1-f49d-4734-9fa8-9bf140be3fbf



## Main Dependencies

- `http`: For making API calls
- `provider`: For state management
- `lottie`: For weather condition animations
- `sqflite`: For local cache storage

  

## Contributions

Contributions are welcome. Please open an issue first to discuss what you would like to change.

## License

[MIT](https://choosealicense.com/licenses/mit/)
