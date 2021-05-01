import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techno_weather/blocs/appplication_bloc.dart';
import 'package:techno_weather/components/loader.dart';
import 'package:techno_weather/components/weather_results_area.dart';
import 'package:techno_weather/models/WeatherForecast.dart';
import 'package:techno_weather/models/WeatherResult.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String searchParam;
  String selectedCity;
  bool isLoading = false;
  WeatherResult currentWeatherResults;
  List<WeatherForecast> weatherForecast;

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[500],
          title: Text(
            'Techno Weather',
            style: TextStyle(color: Colors.blueGrey),
          ),
        ),
        body: Container(
          color: Colors.blueGrey,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: isLoading
              ? Loading()
              : ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Material(
                          elevation: 10.0,
                          shadowColor: Colors.grey[700],
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          child: TextField(
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Cerca località...',
                                suffixIcon: Icon(Icons.search)),
                            onChanged: (value) {
                              setState(() {
                                searchParam = value;
                                applicationBloc.searchPlaces(searchParam);
                              });
                            },
                          )),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 300,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              backgroundBlendMode: BlendMode.darken),
                        ),
                        Container(
                          height: 300,
                          child: applicationBloc.searchResult == null
                              ? Container()
                              : ListView.builder(
                                  itemCount:
                                      applicationBloc.searchResult.length,
                                  itemBuilder: (_, index) {
                                    return ListTile(
                                      title: Text(
                                        applicationBloc
                                            .searchResult[index].placeName,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onTap: () => {
                                        setState(() {
                                          selectedCity = applicationBloc
                                              .searchResult[index].placeName;
                                          searchParam = '';
                                        })
                                      },
                                    );
                                  }),
                        ),
                        // Container(child: WeatherResultsArea())
                      ],
                    )
                  ],
                ),
        ));
  }
}
