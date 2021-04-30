import 'package:flutter/material.dart';
import 'package:techno_weather/components/loader.dart';
import 'package:techno_weather/components/current_weather_widget.dart';
import 'package:techno_weather/components/weather_forecast_widget.dart';
import 'package:techno_weather/models/WeatherForecast.dart';
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
  List<WeatherForecast> weatherForecast;

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
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 10,
                        ),
                        child: ElevatedButton(
                            onPressed: () async {
                              if (_weatherForm.currentState.validate()) {
                                setState(() => isLoading = true);
                                try {
                                  WeatherResult result =
                                      await OpenWeatherMapService()
                                          .fetchWeatherFromLocation(
                                              selectedCity);

                                  if (result == null) {
                                    setState(() => apiError =
                                        'Oops! Qualcosa è andato storto');
                                  } else {
                                    setState(
                                        () => currentWeatherResults = result);
                                  }

                                  List<WeatherForecast> _forecast =
                                      await OpenWeatherMapService()
                                          .fetchForecastFromLocation(
                                              selectedCity);

                                  if (result == null) {
                                    setState(() => apiError =
                                        'Previsioni a 5 giorni non disponibili');
                                  } else {
                                    setState(() => weatherForecast = _forecast);
                                  }
                                } finally {
                                  setState(() => isLoading = false);
                                }
                              }
                            },
                            child: Text('Controlla meteo')),
                      ),
                      Container(
                        child: currentWeatherResults == null
                            ? Container()
                            : CurrentWeatherWidget(
                                location: selectedCity,
                                groupedInfo: currentWeatherResults),
                      ),
                      Container(
                        child: weatherForecast == null
                            ? Container()
                            : WeatherForecastWidget(forecast: weatherForecast),
                      ),
                    ],
                  )),
        ));
  }
}
