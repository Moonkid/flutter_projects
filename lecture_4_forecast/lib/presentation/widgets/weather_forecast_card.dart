import 'package:flutter/material.dart';
import 'package:lecture_4_forecast/domain/entities/forecast.dart';

class WeatherForecastCard extends StatelessWidget {
  const WeatherForecastCard({
    Key key,
    @required Forecast forecast,
  })  : assert(forecast != null),
        _forecast = forecast,
        super(key: key);

  final Forecast _forecast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${_forecast.displayDate}',
              style: Theme.of(context).textTheme.display1,
            ),
            Image.network(_forecast.icon),
            Text(
              '${_forecast.temperature} °C',
              style: Theme.of(context).textTheme.display1,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
