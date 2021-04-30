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
