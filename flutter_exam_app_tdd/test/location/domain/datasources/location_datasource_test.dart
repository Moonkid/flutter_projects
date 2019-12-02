import 'package:flutter/services.dart';
import 'package:flutter_exam_app_tdd/core/error/exception.dart';
import 'package:flutter_exam_app_tdd/location/data/datasources/location_datasource_impl.dart';
import 'package:flutter_exam_app_tdd/location/data/models/CoordinatesModel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import 'package:geolocator/geolocator.dart';

class MockGeolocator extends Mock implements Geolocator {}

void main() {
  final position = Position(latitude: 0, longitude: 0);
  const coordinates = CoordinatesModel(latitude: 0, longitude: 0);
  LocationDatasourceImpl datasource;
  Geolocator mockGeolocator;

  setUp(() {
    mockGeolocator = MockGeolocator();
    datasource = LocationDatasourceImpl(mockGeolocator);
  });

  test('should call a getCurrentPosition', () async {
    when(mockGeolocator.getCurrentPosition()).thenAnswer((_) async => position);
    await datasource.getPosition();
    verify(mockGeolocator.getCurrentPosition());
  });

  test('should return a valid position when getPosition() call is successful',
      () async {
    when(mockGeolocator.getCurrentPosition()).thenAnswer((_) async => position);
    final result = await datasource.getPosition();
    verify(mockGeolocator.getCurrentPosition());
    expect(result, equals(coordinates));
  });

  test('should throw PositionException when unable to get current position',
      () {
    when(mockGeolocator.getCurrentPosition()).thenThrow(PlatformException(
        code: 'PERMISSION_DENIED',
        message: 'Access to location data denied',
        details: null));
    expect(() => datasource.getPosition(),
        throwsA(const TypeMatcher<PositionException>()));
  });
}
