import 'package:intl/intl.dart';
import 'package:lecture_4_forecast/domain/entities/forecast.dart';

class ForecastModel extends Forecast {
  const ForecastModel({
    String location,
    String icon,
    String description,
    int temperature,
    String displayDate,
  }) : super(
          location: location,
          icon: icon,
          description: description,
          temperature: temperature,
          displayDate: displayDate,
        );

  factory ForecastModel.fromMap(Map<String, dynamic> map) {
    final Map<String, dynamic> weather = map['weather'][0];
    final num t = map['main']['temp'];
    return ForecastModel(
      location: map['name'],
      icon: _buildIconUrl(iconId: weather['icon']),
      description: weather['description'],
      temperature: t.ceil(),
      displayDate: _dateStringFromTimestamp(map['dt']),
    );
  }

  static String _buildIconUrl({String iconId}) {
    return 'https://openweathermap.org/img/wn/$iconId@2x.png';
  }

  static String _dateStringFromTimestamp(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final formatter = DateFormat('E, dd');
    final result = formatter.format(date);
    return result;
  }
}
