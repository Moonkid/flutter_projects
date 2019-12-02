library location_events;

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetCurrentPosition extends LocationEvent {}
