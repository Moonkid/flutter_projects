import 'package:location_permissions/location_permissions.dart';

abstract class PermissionsManager {
  Future<PermissionStatus> permissionStatus();

  Future<PermissionStatus> requestPermissions();
}

class PermissionsManagerImpl extends PermissionsManager {
  PermissionsManagerImpl(
    LocationPermissions locationPermissions,
  ) : _locationPermissions = locationPermissions;

  final LocationPermissions _locationPermissions;

  @override
  Future<PermissionStatus> permissionStatus() {
    return _locationPermissions.checkPermissionStatus();
  }

  @override
  Future<PermissionStatus> requestPermissions() {
    return _locationPermissions.requestPermissions();
  }
}
