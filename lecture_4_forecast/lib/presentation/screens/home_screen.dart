import 'package:flutter/material.dart';
import 'package:lecture_4_forecast/domain/repositories/weather_repository.dart';
import 'package:lecture_4_forecast/presentation/widgets/three_day_forecast.dart';
import 'package:lecture_4_forecast/presentation/widgets/weather_overview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    @required WeatherRepository repository,
  }) : _repository = repository;

  final WeatherRepository _repository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return orientation == Orientation.portrait ? WeatherOverview(repository: _repository,) : ThreeDayForecast(repository: _repository,);
        },
      ),
    );
  }
}
