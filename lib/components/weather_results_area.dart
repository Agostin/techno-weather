import 'package:flutter/material.dart';
import 'package:techno_weather/components/weather_forecast_widget.dart';
import 'package:techno_weather/models/WeatherForecast.dart';
import 'package:techno_weather/models/WeatherResult.dart';

import 'current_weather_widget.dart';

class WeatherResultsArea extends StatelessWidget {
  final String selectedCity;
  final WeatherResult currentWeatherResults;
  final List<WeatherForecast> weatherForecast;

  WeatherResultsArea(
      {this.selectedCity, this.currentWeatherResults, this.weatherForecast});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView(
      children: <Widget>[
        Container(
          child: currentWeatherResults == null
              ? Container()
              : CurrentWeatherWidget(
                  location: selectedCity, groupedInfo: currentWeatherResults),
        ),
        Container(
          child: weatherForecast == null
              ? Container()
              : WeatherForecastWidget(forecast: weatherForecast),
        ),
      ],
    ));
  }
}
