import 'package:flutter/material.dart';
import 'package:techno_weather/components/loader.dart';
import 'package:techno_weather/components/current_weather_widget.dart';
import 'package:techno_weather/models/WeatherResult.dart';
import 'package:techno_weather/services/openweathermap.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  GlobalKey<FormState> _weatherForm = GlobalKey();

  String selectedCity;
  bool isLoading = false;
  String apiError = '';
  WeatherResult currentWeatherResults;
  dynamic fiveDaysForecastResults;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[500],
          title: Text(
            'Techno Weather',
            style: TextStyle(color: Colors.blueGrey),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: isLoading
              ? Loading()
              : Form(
                  key: _weatherForm,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (val) => val.isEmpty
                            ? 'Digita un nome valido di una località'
                            : null,
                        decoration:
                            InputDecoration(hintText: 'Cerca località...'),
                        onChanged: (value) {
                          setState(() => selectedCity = value);
                        },
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_weatherForm.currentState.validate()) {
                              setState(() => isLoading = true);
                              try {
                                WeatherResult result =
                                    await OpenWeatherMapService()
                                        .fetchWeatherFromLocation(selectedCity);

                                if (result == null) {
                                  setState(() => apiError =
                                      'Oops! Qualcosa è andato storto');
                                } else {
                                  setState(
                                      () => currentWeatherResults = result);
                                }
                              } finally {
                                setState(() => isLoading = false);
                              }
                            }
                          },
                          child: Text('Controlla meteo')),
                      SizedBox(
                        height: 200,
                        child: CurrentWeatherWidget(
                            location: selectedCity.trim(),
                            groupedInfo: currentWeatherResults),
                      ),
                    ],
                  )),
        ));
  }
}
