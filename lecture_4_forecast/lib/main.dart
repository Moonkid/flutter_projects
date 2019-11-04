import 'package:flutter/material.dart';
import 'package:lecture_4_forecast/data/repositories/openweather_repository.dart';
import 'package:lecture_4_forecast/presentation/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(
        repository: OpenWeatherRepository(),
      ),
    );
  }
}
