library location_states;

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_exam_app_tdd/location/domain/models/coordinates.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

class Initial extends LocationState {}

class Loading extends LocationState {}

class Updated extends LocationState {
  const Updated(
    this.position,
  );

  final Coordinates position;

  @override
  List<Object> get props => [position];
}

class Error extends LocationState {
  const Error({
    @required this.message,
  });

  final String message;
  @override
  List<Object> get props => [message];
}