import 'package:flutter/material.dart';
import 'package:techno_weather/models/WeatherMainInfo.dart';
import 'package:techno_weather/models/WeatherRecord.dart';
import 'package:techno_weather/models/WeatherResult.dart';

class CurrentWeatherWidget extends StatelessWidget {
  final String location;
  final WeatherResult groupedInfo;

  CurrentWeatherWidget({this.groupedInfo, this.location});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final WeatherMainInfo mainInfo = this.groupedInfo.main;
    final List<WeatherRecord> weatherDetails = this.groupedInfo.weather;

    return Container(
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'IL METEO DI',
                          style: TextStyle(fontSize: 16),
                        )),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          this.location.toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Image.network(weatherDetails[0].icon),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          '${mainInfo.temp}°C',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 42),
                        )),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          weatherDetails[0].description,
                          style: TextStyle(fontSize: 16),
                        )),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
