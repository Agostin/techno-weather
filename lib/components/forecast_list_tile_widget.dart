import 'package:flutter/material.dart';
import 'package:techno_weather/models/WeatherForecast.dart';

class ForecastListTileWidget extends StatelessWidget {
  final WeatherForecast info;

  ForecastListTileWidget(this.info);

  String secondsToDateDay(int seconds) {
    final List<String> daysOfWeek = [
      'Lunedì',
      'Mertedì',
      'Mercoledì',
      'Giovedì',
      'Venerdì',
      'Sabato',
      'Domenica'
    ];

    DateTime date = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
    return '${daysOfWeek[date.weekday - 1]} ${date.day}/${date.month}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              flex: 5,
              child: Column(
                children: [
                  Text(
                    secondsToDateDay(this.info.dateInSeconds),
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 18),
                  )
                ],
              )),
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(children: [
                    Text(
                      '${this.info.forecast.main.tempMin}°C',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${this.info.forecast.main.tempMax}°C',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ])
                ],
              )),
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Image.network(this.info.forecast.weather[0].icon)],
              )),
        ],
      ),
    ));
  }
}
