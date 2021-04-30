import 'package:techno_weather/models/WeatherResult.dart';

class WeatherForecast {
  final int dateInSeconds;
  final WeatherResult forecast;

  WeatherForecast({this.dateInSeconds, this.forecast});
}
