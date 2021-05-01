import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:techno_weather/models/WeatherForecast.dart';
import 'package:techno_weather/models/WeatherMainInfo.dart';
import 'package:techno_weather/models/WeatherRecord.dart';
import 'package:techno_weather/models/WeatherResult.dart';

class OpenWeatherMapService {
  final String lang = 'it';
  final String baseAPIPath = 'https://api.openweathermap.org/data/2.5';
  final String apiKey = 'b57c1a0928b2875dd5991a1d9b49e824';
  final String apiOptions = 'lang=it&units=metric';
  final client = http.Client();

  WeatherResult _parseURIResponse(String apiResponseBody) {
    final dynamic parsedBody = jsonDecode(apiResponseBody);
    final List<WeatherRecord> weatherRecords = parsedBody['weather']
        .map<WeatherRecord>((json) => WeatherRecord.fromJson(json))
        .toList();

    return WeatherResult(
        weather: weatherRecords,
        main: WeatherMainInfo.fromJson(parsedBody['main']));
  }

  Future<WeatherResult> fetchWeatherFromLocation(String location) async {
    try {
      http.Response uriResponse = await client.get(Uri.parse(
          '${this.baseAPIPath}/weather?$apiOptions&q=$location&appid=$apiKey'));

      return uriResponse.statusCode == 200
          ? _parseURIResponse(uriResponse.body)
          : [];
    } finally {
      client.close();
    }
  }

  List<WeatherForecast> _parseForecastResponse(String apiResponseBody) {
    final dynamic parsedBody = jsonDecode(apiResponseBody);
    final List<dynamic> jsonForecast = parsedBody['list'];

    return jsonForecast
        .map((json) => WeatherForecast(
            dateInSeconds: json['dt'] as int,
            forecast: WeatherResult(
                main: WeatherMainInfo.fromJson(json['main']),
                weather: json['weather']
                    .map<WeatherRecord>((w) => WeatherRecord.fromJson(w))
                    .toList())))
        .toList();
  }

  Future<List<WeatherForecast>> fetchForecastFromLocation(
      String location) async {
    try {
      dynamic uriResponse = await client.get(Uri.parse(
          '${this.baseAPIPath}/forecast?$apiOptions&q=$location&appid=$apiKey'));

      return uriResponse.statusCode == 200
          ? _parseForecastResponse(uriResponse.body)
          : [];
    } finally {
      client.close();
    }
  }
}
