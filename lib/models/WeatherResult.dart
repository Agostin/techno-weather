import 'WeatherMainInfo.dart';
import 'WeatherRecord.dart';

class WeatherResult {
  final List<WeatherRecord> weather;
  final WeatherMainInfo main;

  WeatherResult({this.weather, this.main});
}
