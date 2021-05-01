import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techno_weather/blocs/application_bloc.dart';
import 'package:techno_weather/screens/weather/weather_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        title: 'Techno Weather',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WeatherScreen(),
      ),
    );
  }
}
