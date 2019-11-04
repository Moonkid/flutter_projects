import 'package:flutter/material.dart';
import 'package:lecture_4_forecast/domain/entities/forecast.dart';
import 'package:lecture_4_forecast/domain/repositories/weather_repository.dart';
import 'package:lecture_4_forecast/presentation/widgets/weather_forecast_card.dart';

class ThreeDayForecast extends StatelessWidget {
  const ThreeDayForecast({
    @required WeatherRepository repository,
  }) : _repository = repository;

  final WeatherRepository _repository;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Forecast>>(
      future: _repository.threeDayForecast(),
      builder: (context, snapshot) {
        return Align(
            alignment: Alignment.center, child: _buildChild(context, snapshot));
      },
    );
  }

  Widget _buildChild(
      BuildContext context, AsyncSnapshot<List<Forecast>> snapshot) {
    if (snapshot.hasData) {
      return Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '${snapshot.data.first.location}',
                style: Theme.of(context).textTheme.display2,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: snapshot.data
                  .map((forecast) => AspectRatio(
                      aspectRatio: 1,
                      child: WeatherForecastCard(forecast: forecast)))
                  .toList(),
            ),
          ),
        ],
      );
    } else if (snapshot.hasError) {
      Text('${snapshot.error}');
    }
    return const CircularProgressIndicator();
  }
}
