import 'package:flutter/material.dart';
import 'package:lecture_4_forecast/domain/entities/forecast.dart';

class WeatherOverviewCard extends StatelessWidget {
  const WeatherOverviewCard({
    Key key,
    @required Forecast forecast,
  })  : assert(forecast != null),
        _forecast = forecast,
        super(key: key);

  final Forecast _forecast;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${_forecast.location}',
            style: Theme.of(context).textTheme.display2,
          ),
          Image.network(_forecast.icon),
          Text(
            '${_forecast.temperature} °C',
            style: Theme.of(context).textTheme.display1,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
