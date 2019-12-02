import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_exam_app_tdd/location/bloc/bloc.dart';
import 'package:flutter_exam_app_tdd/location/usecases/location_usecase.dart';
import 'package:meta/meta.dart';
import 'package:flutter_exam_app_tdd/location/bloc/location_event.dart';
import 'package:flutter_exam_app_tdd/location/bloc/location_state.dart'
    as location_states;
import 'package:flutter_exam_app_tdd/location/bloc/location_state.dart';
import 'package:flutter_exam_app_tdd/core/strings.dart' as strings;

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc({
    @required LocationUsecase usecase,
  }) : _usecase = usecase;

  final LocationUsecase _usecase;

  @override
  LocationState get initialState => location_states.Initial();

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is GetCurrentPosition) {
      yield Loading();
      final currentPosition = await _usecase();
      yield currentPosition.fold(
          (failure) => location_states.Error(
              message: strings.mapFailureToMessage(failure)),
          (position) => Updated(position));
    }
  }
}
