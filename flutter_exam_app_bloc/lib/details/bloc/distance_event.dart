library user_event;

import 'package:equatable/equatable.dart';

abstract class DistanceEvent extends Equatable {
  const DistanceEvent();

  @override
  List<Object> get props => [];
}

class CalculateDistance extends DistanceEvent {}
