import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techno_weather/blocs/appplication_bloc.dart';
import 'package:techno_weather/components/loader.dart';
import 'package:techno_weather/components/weather_results_area.dart';
import 'package:techno_weather/models/WeatherForecast.dart';
import 'package:techno_weather/models/WeatherResult.dart';
import 'package:techno_weather/services/openweathermap.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  bool isLoading = false;
  String searchParam;
  bool locationHasBeenSelectd = false;
  FocusNode _node;

  String selectedCity = '';
  dynamic currentWeatherResults;
  dynamic weatherForecast;

  @override
  void initState() {
    super.initState();
    _node = FocusNode();
    _node.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    if (_node.hasFocus) {
      selectedCity = '';
      searchParam = '';
      locationHasBeenSelectd = false;
    }
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[500],
          title: Text(
            'Techno Weather',
            style: TextStyle(color: Colors.blueGrey),
          ),
        ),
        body: isLoading
            ? Loading()
            : Container(
                color: Colors.blueGrey,
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Material(
                        elevation: 10.0,
                        shadowColor: Colors.grey[700],
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: TextField(
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Cerca località...',
                              suffixIcon: Icon(Icons.search)),
                          focusNode: _node,
                          onChanged: (value) {
                            setState(() {
                              searchParam = value;
                              if (searchParam.length >= 2) {
                                applicationBloc.searchPlaces(searchParam);
                              }
                            });
                          },
                        )),
                    !locationHasBeenSelectd
                        ? Stack(
                            children: [
                              Container(
                                height: selectedCity == null ? 0 : 300,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.6),
                                    backgroundBlendMode: BlendMode.darken),
                              ),
                              Container(
                                height: selectedCity == null ? 0 : 300,
                                child: applicationBloc.searchResult == null
                                    ? Row()
                                    : ListView.builder(
                                        itemCount:
                                            applicationBloc.searchResult.length,
                                        itemBuilder: (_, index) {
                                          return ListTile(
                                            title: Text(
                                              applicationBloc
                                                  .searchResult[index]
                                                  .placeName,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onTap: () async {
                                              setState(() {
                                                isLoading = true;
                                                selectedCity = applicationBloc
                                                    .searchResult[index]
                                                    .placeName;
                                                locationHasBeenSelectd = true;
                                              });

                                              WeatherResult
                                                  _currentWeatherResults =
                                                  await OpenWeatherMapService()
                                                      .fetchWeatherFromLocation(
                                                          selectedCity);
                                              List<WeatherForecast>
                                                  _weatherForecast =
                                                  await OpenWeatherMapService()
                                                      .fetchForecastFromLocation(
                                                          selectedCity);

                                              setState(() {
                                                if (_currentWeatherResults !=
                                                    null) {
                                                  currentWeatherResults =
                                                      _currentWeatherResults;
                                                }
                                                if (_weatherForecast != null) {
                                                  weatherForecast =
                                                      _weatherForecast;
                                                }
                                                isLoading = false;
                                                selectedCity = '';
                                              });
                                            },
                                          );
                                        }),
                              ),
                            ],
                          )
                        : Column(children: [
                            SizedBox(
                              height: 30,
                            ),
                            WeatherResultsArea(
                              selectedCity: selectedCity,
                              weatherForecast: weatherForecast,
                              currentWeatherResults: currentWeatherResults,
                            )
                          ]),
                  ],
                ),
              ));
  }
}
