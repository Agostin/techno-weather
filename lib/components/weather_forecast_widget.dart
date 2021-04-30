import 'package:flutter/material.dart';
import 'package:techno_weather/models/WeatherForecast.dart';

import 'forecast_list_tile_widget.dart';

class WeatherForecastWidget extends StatelessWidget {
  final List<WeatherForecast> forecast;

  WeatherForecastWidget({this.forecast});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Row(
      children: <Widget>[
        Expanded(
            child: SizedBox(
                height: size.height * 0.5,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  separatorBuilder: (_, index) => Divider(),
                  itemCount: this.forecast.length,
                  itemBuilder: (_, index) =>
                      ForecastListTileWidget(this.forecast[index]),
                )))
      ],
    );
  }
}
