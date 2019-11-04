import 'package:flutter/material.dart';
import 'package:lecture_4_forecast/domain/entities/forecast.dart';
import 'package:lecture_4_forecast/domain/repositories/weather_repository.dart';
import 'package:lecture_4_forecast/presentation/widgets/weather_overview_card.dart';


class WeatherOverview extends StatelessWidget {
  const WeatherOverview({
    @required WeatherRepository repository,
  }) : _repository = repository;

  final WeatherRepository _repository;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Forecast>(
      future: _repository.currentWeather(),
      builder: (context, snapshot) {
        return Align(alignment: Alignment.center, child: _buildChild(snapshot));
      },
    );
  }

  Widget _buildChild(AsyncSnapshot<Forecast> snapshot) {
    if (snapshot.hasData) {
      return AspectRatio(
          aspectRatio: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: WeatherOverviewCard(forecast: snapshot.data),
          ));
    } else if (snapshot.hasError) {
      Text('${snapshot.error}');
    }
    return const CircularProgressIndicator();
  }
}
