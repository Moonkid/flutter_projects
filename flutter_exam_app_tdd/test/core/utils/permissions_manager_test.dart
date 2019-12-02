//
// Created by Pavel Pozdniakov on 12/2/19.
// Copyright (c) 2019 SSA Group. All rights reserved.
//

import 'package:flutter_exam_app_tdd/core/utils/permissions_manager.dart';
import 'package:mockito/mockito.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:flutter_test/flutter_test.dart';

class MockLocationPermissions extends Mock implements LocationPermissions {}

void main() {
  LocationPermissions mockLocationPermissions;
  PermissionsManager manager;

  setUp(() {
    mockLocationPermissions = MockLocationPermissions();
    manager = PermissionsManagerImpl(mockLocationPermissions);
  });

  test(
      'should forward permissionStatus() call to LocationPermissions.checkPermissionStatus()',
      () async {
    when(mockLocationPermissions.checkPermissionStatus())
        .thenAnswer((_) async => PermissionStatus.unknown);
    final status = await manager.permissionStatus();
    verify(mockLocationPermissions.checkPermissionStatus());
    expect(status, equals(PermissionStatus.unknown));
  });

  test(
      'should forward requestPermissions() call to LocationPermissions.requestPermissions()',
      () async {
    when(mockLocationPermissions.requestPermissions())
        .thenAnswer((_) async => PermissionStatus.granted);
    final status = await manager.requestPermissions();
    verify(mockLocationPermissions.requestPermissions());
    expect(status, equals(PermissionStatus.granted));
  });
}
