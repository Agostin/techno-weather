import 'package:flutter/material.dart';
import 'package:techno_weather/models/WeatherForecast.dart';

import 'forecast_list_tile_widget.dart';

class WeatherForecastWidget extends StatelessWidget {
  final List<WeatherForecast> forecast;

  WeatherForecastWidget({this.forecast});

  List<WeatherForecast> _extract5DayForecast(List<WeatherForecast> forecast) {
    final List<WeatherForecast> _list = forecast;
    _list.removeWhere((element) => forecast.indexOf(element) % 8 != 0);
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<WeatherForecast> dailyForecast =
        _extract5DayForecast(this.forecast);

    return Row(
      children: <Widget>[
        Expanded(
            child: SizedBox(
                height: size.height * 0.5,
                child: ListView.separated(
                  separatorBuilder: (_, index) => Divider(),
                  itemCount: dailyForecast.length,
                  itemBuilder: (_, index) =>
                      ForecastListTileWidget(dailyForecast[index]),
                ))),
      ],
    );
  }
}
