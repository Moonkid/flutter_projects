import 'dart:async';
import 'dart:convert';

import 'package:lecture_4_forecast/data/models/forecast_model.dart';
import 'package:lecture_4_forecast/domain/entities/forecast.dart';
import 'package:lecture_4_forecast/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;

class OpenWeatherRepository extends WeatherRepository {
  @override
  Future<Forecast> currentWeather() async {
    const url =
        'https://api.openweathermap.org/data/2.5/weather?q=Kharkiv&units=metric&APPID=1ea55013049215603ece3fee22806975';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      return ForecastModel.fromMap(jsonMap);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  @override
  Future<List<Forecast>> threeDayForecast() async {
    const url =
        'https://api.openweathermap.org/data/2.5/forecast?q=kharkiv&units=metric&APPID=1ea55013049215603ece3fee22806975';
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      final parsedForecastList = _parseJsonList(jsonMap['list']);
      final result = parsedForecastList.length > 2
          ? parsedForecastList.sublist(0, 3)
          : parsedForecastList;

      return result;
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  List<Forecast> _parseJsonList(List list) {
    return list
        .map((dynamic jsonWeather) {
          return ForecastModel.fromMap(jsonWeather).copyWith(location: 'Kharkiv');
        })
        .toSet()
        .toList();
  }
}
