class WeatherResult {
  final List<WeatherRecord> weather;
  final WeatherMainInfo main;

  WeatherResult({this.weather, this.main});
}

class WeatherMainInfo {
  final dynamic temp;
  final dynamic feelsLike;
  final dynamic tempMin;
  final dynamic tempMax;
  final dynamic pressure;
  final dynamic humidity;

  WeatherMainInfo(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.humidity,
      this.pressure});

  factory WeatherMainInfo.fromJson(dynamic json) {
    return WeatherMainInfo(
        temp: json['temp'].toStringAsFixed(0),
        feelsLike: json['feels_like'].toStringAsFixed(0),
        tempMin: json['temp_min'].toStringAsFixed(0),
        tempMax: json['temp_max'].toStringAsFixed(0),
        pressure: json['pressure'],
        humidity: json['humidity']);
  }
}

class WeatherRecord {
  final int id;
  final String main;
  final String description;
  final String icon;

  WeatherRecord({this.id, this.main, this.description, this.icon});

  factory WeatherRecord.fromJson(dynamic json) {
    return WeatherRecord(
        id: json['id'] as int,
        main: json['main'] as String,
        description: json['description'] as String,
        icon: 'https://openweathermap.org/img/wn/${json['icon']}@2x.png');
  }
}
