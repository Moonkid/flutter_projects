library user_state;

import 'package:equatable/equatable.dart';
import 'package:latlong/latlong.dart';
import 'package:meta/meta.dart';

abstract class DistanceState extends Equatable {
  const DistanceState();

  @override
  List<Object> get props => [];
}

class Loading extends DistanceState {}
class Initial extends DistanceState {}

class Error extends DistanceState {
  const Error({
    @required this.message,
  });

  final String message;
}

class DistanceCalculated extends DistanceState {
  const DistanceCalculated(this.distance);

  final num distance;
}
