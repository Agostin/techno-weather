import 'package:flutter/material.dart';
import 'package:techno_weather/components/loader.dart';
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
    final Size size = MediaQuery.of(context).size;

    return Container(
        height: size.height * .8,
        width: double.infinity,
        child: selectedCity == null
            ? Loading()
            : ListView(
                children: <Widget>[
                  Container(
                    child: currentWeatherResults == null
                        ? Container()
                        : CurrentWeatherWidget(
                            location: selectedCity,
                            groupedInfo: currentWeatherResults),
                  ),
                  SizedBox(
                    height: 10,
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
