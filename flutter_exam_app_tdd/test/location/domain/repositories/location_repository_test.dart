import 'package:dartz/dartz.dart';
import 'package:flutter_exam_app_tdd/core/utils/permissions_manager.dart';
import 'package:flutter_exam_app_tdd/location/data/repositories/location_repository_impl.dart';
import 'package:flutter_exam_app_tdd/location/datasources/location_datasource.dart';
import 'package:flutter_exam_app_tdd/location/domain/models/coordinates.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockLocationDatasource extends Mock implements LocationDatasource {}

class MockPermissionsManager extends Mock implements PermissionsManager {}

void main() {
  const coordinates = Coordinates(latitude: 0, longitude: 0);

  LocationDatasource datasource;
  LocationRepositoryImpl repository;
  PermissionsManager permissionsManager;

  setUp(() {
    permissionsManager = MockPermissionsManager();
    datasource = MockLocationDatasource();
    repository = LocationRepositoryImpl(
        datasource: datasource, permissionsManager: permissionsManager);
  });

  test('should ask for permissions when permissions not granted', () async {
    when(datasource.getPosition()).thenAnswer((_) async => coordinates);
  });
}
