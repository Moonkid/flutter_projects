import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Coordinates extends Equatable {
  const Coordinates({
    @required this.latitude,
    @required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  List<Object> get props => [latitude, longitude];
}