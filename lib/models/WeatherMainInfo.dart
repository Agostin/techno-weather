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
