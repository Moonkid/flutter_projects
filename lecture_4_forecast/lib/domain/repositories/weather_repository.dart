import 'dart:async';

import 'package:lecture_4_forecast/domain/entities/forecast.dart';

abstract class WeatherRepository {

  Future<Forecast> currentWeather();

  Future<List<Forecast>> threeDayForecast();
  
}