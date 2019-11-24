import 'package:flutter/material.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';

enum LocationStatus { undefined, loading, loaded, error }

class LocationProvider with ChangeNotifier {
  LocationStatus status = LocationStatus.undefined;
  String error;
  LatLng currentPosition;

  Future<void> updateLocation() async {
    _yieldLoadingStatus();
    try {
      final permission = LocationPermissions();
      await permission.requestPermissions();

      final geolocator = Geolocator();
      final position = await geolocator.getLastKnownPosition(
          desiredAccuracy: LocationAccuracy.high);
      currentPosition = LatLng(position.latitude, position.longitude);
      status = LocationStatus.loaded;
      notifyListeners();
    } catch (_) {
      error = 'Please turn on the geolocation';
      status = LocationStatus.error;
      notifyListeners();
    }
  }

  void _yieldLoadingStatus() {
    error = null;
    currentPosition = null;
    status = LocationStatus.loading;
    notifyListeners();
  }
}
