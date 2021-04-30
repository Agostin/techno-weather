import 'package:flutter/material.dart';
import 'package:techno_weather/models/WeatherForecast.dart';

class ForecastListTileWidget extends StatelessWidget {
  final WeatherForecast info;

  ForecastListTileWidget(this.info);

  String secondsToDateDay(int seconds) {
    return DateTime.fromMillisecondsSinceEpoch(seconds).day.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: Row(
          children: [
            Column(
              children: [Text(this.info.dateInSeconds.toString())],
            ),
            Column(
              children: [Image.network(this.info.forecast.weather[0].icon)],
            ),
            Column(
              children: [
                Text(
                  '${this.info.forecast.main.tempMin}°C',
                  style: TextStyle(
                      color: Colors.lightBlue, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${this.info.forecast.main.tempMax}°C',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
