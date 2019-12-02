import 'package:dartz/dartz.dart';
import 'package:flutter_exam_app_tdd/core/error/exception.dart';
import 'package:flutter_exam_app_tdd/core/error/failure.dart';
import 'package:flutter_exam_app_tdd/core/utils/permissions_manager.dart';
import 'package:flutter_exam_app_tdd/location/data/repositories/location_repository_impl.dart';
import 'package:flutter_exam_app_tdd/location/domain/datasources/location_datasource.dart';
import 'package:flutter_exam_app_tdd/location/domain/models/coordinates.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLocationDatasource extends Mock implements LocationDatasource {}

class MockPermissionsManager extends Mock implements PermissionsManager {}

void main() {
  const coordinates = Coordinates(latitude: 0, longitude: 0);

  LocationDatasource mockDatasource;
  LocationRepositoryImpl repository;
  PermissionsManager mockPermissionsManager;

  setUp(() {
    mockPermissionsManager = MockPermissionsManager();
    mockDatasource = MockLocationDatasource();
    repository = LocationRepositoryImpl(
        datasource: mockDatasource, permissionsManager: mockPermissionsManager);
  });

  test('should check if permissions granted when asked for position', () {
    when(mockPermissionsManager.permissionStatus())
        .thenAnswer((_) async => PermissionStatus.granted);
    repository.getPosition();
    verify(mockPermissionsManager.permissionStatus());
  });

  test('should ask for permissions when permissions not granted', () async {
    when(mockPermissionsManager.permissionStatus())
        .thenAnswer((_) async => PermissionStatus.unknown);
    await repository.getPosition();
    verify(mockPermissionsManager.requestPermissions());
  });

  test('should not ask for permissions when permissions granted', () async {
    when(mockPermissionsManager.permissionStatus())
        .thenAnswer((_) async => PermissionStatus.granted);
    await repository.getPosition();
    verifyNever(mockPermissionsManager.requestPermissions());
  });

  test('should return a PermissionFailure when permissions denied', () async {
    when(mockPermissionsManager.permissionStatus())
        .thenAnswer((_) async => PermissionStatus.denied);
    final result = await repository.getPosition();
    expect(result, equals(Left<Failure, Coordinates>(PermissionFailure())));
  });

  test('should return correct coordinates when datasource call is successful',
      () async {
    when(mockPermissionsManager.permissionStatus())
        .thenAnswer((_) async => PermissionStatus.granted);
    when(mockDatasource.getPosition()).thenAnswer((_) async => coordinates);
    final result = await repository.getPosition();
    verify(mockDatasource.getPosition());
    expect(result, equals(Right<Failure, Coordinates>(coordinates)));
  });

  test('should return PositionFailure when datasource call is unsuccessful',
      () async {
    when(mockPermissionsManager.permissionStatus())
        .thenAnswer((_) async => PermissionStatus.granted);
    when(mockDatasource.getPosition()).thenThrow(PositionException());
    final result = await repository.getPosition();
    verify(mockDatasource.getPosition());
    expect(result, equals(Left<Failure, Coordinates>(PositionFailure())));
  });
}
