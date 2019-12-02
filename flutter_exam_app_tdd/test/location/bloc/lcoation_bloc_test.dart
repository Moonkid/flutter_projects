import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_exam_app_tdd/core/error/failure.dart';
import 'package:flutter_exam_app_tdd/core/strings.dart' as strings;
import 'package:flutter_exam_app_tdd/location/bloc/bloc.dart';
import 'package:flutter_exam_app_tdd/location/bloc/location_state.dart'
    as locations_states;
import 'package:flutter_exam_app_tdd/location/bloc/location_event.dart'
    as locations_events;
import 'package:flutter_exam_app_tdd/location/domain/models/coordinates.dart';
import 'package:flutter_exam_app_tdd/location/usecases/location_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLocationUsecase extends Mock implements LocationUsecase {}

void main() {
  const position = Coordinates(latitude: 16, longitude: 20);
  LocationUsecase usecase;
  LocationBloc bloc;
  setUp(() {
    usecase = MockLocationUsecase();
    bloc = LocationBloc(usecase: usecase);
  });

  test('state should be Initial when bloc created', () {
    expect(bloc.initialState, equals(locations_states.Initial()));
  });

  test('should check current position to calculate distance', () async {
    when(usecase()).thenAnswer((_) async => Right(position));
    bloc.add(locations_events.GetCurrentPosition());
    await untilCalled(usecase());
    verify(usecase());
  });

  blocTest<LocationBloc, LocationEvent, LocationState>(
      'should emit updated state when position is defined', build: () {
    when(usecase()).thenAnswer((_) async => Right(position));
    return LocationBloc(usecase: usecase);
  }, act: (bloc) {
    bloc.add(GetCurrentPosition());
    return;
  }, expect: <LocationState>[
    locations_states.Initial(),
    locations_states.Loading(),
    const locations_states.Updated(position)
  ]);

  blocTest<LocationBloc, LocationEvent, LocationState>(
      'should emit Error state with permissions failure message when unable to update position',
      build: () {
    when(usecase()).thenAnswer((_) async => Left(PermissionFailure()));
    return LocationBloc(usecase: usecase);
  }, act: (bloc) {
    bloc.add(GetCurrentPosition());
    return;
  }, expect: <LocationState>[
    locations_states.Initial(),
    locations_states.Loading(),
    locations_states.Error(message: strings.permissionFailureMessage)
  ]);

  blocTest<LocationBloc, LocationEvent, LocationState>(
      'should emit Error state with position failure message when unable to update position',
      build: () {
    when(usecase()).thenAnswer((_) async => Left(PositionFailure()));
    return LocationBloc(usecase: usecase);
  }, act: (bloc) {
    bloc.add(GetCurrentPosition());
    return;
  }, expect: <LocationState>[
    locations_states.Initial(),
    locations_states.Loading(),
    locations_states.Error(message: strings.positionFailureMessage)
  ]);
}
