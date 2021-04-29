import 'dart:convert';
import 'package:http/http.dart' as http;
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

  fetchWeatherFromLocation(String location) async {
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

  fetch5dForecastFromLocation(String location) async {
    try {
      dynamic uriResponse = await client.get(Uri.parse(
          '${this.baseAPIPath}/forecast?$apiOptions&q=$location&appid=$apiKey'));
      print(uriResponse.body);
      return _parseURIResponse(uriResponse);
    } finally {
      client.close();
    }
  }
}
