import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Forecast extends Equatable {
  const Forecast({
    @required this.location,
    @required this.icon,
    @required this.description,
    @required this.temperature,
    @required this.displayDate,
  });

  final String location;
  final String icon;
  final String description;
  final int temperature;
  final String displayDate;

  @override
  List<Object> get props => [displayDate];

  Forecast copyWith({
    String location,
    String icon,
    String description,
    num temperature,
    String displayDate,
  }) {
    return Forecast(
      location: location ?? this.location,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      temperature: temperature ?? this.temperature,
      displayDate: displayDate ?? this.displayDate,
    );
  }
}