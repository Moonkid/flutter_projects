import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_exam_app_tdd/location/usecases/location_usecase.dart';
import 'package:meta/meta.dart';
import 'package:flutter_exam_app_tdd/location/bloc/location_event.dart';
import 'package:flutter_exam_app_tdd/location/bloc/location_state.dart' as location_states;
import 'package:flutter_exam_app_tdd/location/bloc/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  LocationBloc({
    @required LocationUsecase usecase,
  }) : _usecase = usecase;

  LocationUsecase _usecase;

  @override
  LocationState get initialState => location_states.Initial();

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    // TODO: Add Logic
  }

}
