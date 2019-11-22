import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_exam_app_bloc/models/user.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:location_permissions/location_permissions.dart';
import './bloc.dart';
import 'distance_event.dart' as user_event;
import 'distance_state.dart' as user_state;

class DistanceBloc extends Bloc<DistanceEvent, DistanceState> {
  DistanceBloc({
    @required User user,
  }) : _user = user;

  final User _user;

  @override
  DistanceState get initialState => user_state.Initial();

  @override
  Stream<DistanceState> mapEventToState(
    DistanceEvent event,
  ) async* {
    if (event is user_event.CalculateDistance) {
      yield user_state.Loading();
      try {
        final permission = LocationPermissions();
        await permission.requestPermissions();

        final geolocator = Geolocator();
        final position = await geolocator.getLastKnownPosition(
            desiredAccuracy: LocationAccuracy.high);
        final km = const Distance().as(
            LengthUnit.Kilometer,
            LatLng(position.latitude, position.longitude),
            LatLng(_user.latitude, _user.longitude));
        yield user_state.DistanceCalculated(km);
      } catch (_) {
        yield const user_state.Error(message: 'Please turn on the geolocation');
      }
    }
  }
}
