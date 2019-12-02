import 'package:dartz/dartz.dart';
import 'package:flutter_exam_app_tdd/core/error/failure.dart';
import 'package:flutter_exam_app_tdd/location/domain/models/coordinates.dart';
import 'package:flutter_exam_app_tdd/location/usecases/location_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_exam_app_tdd/location/domain/repositories/location_repository.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  const coordinates = Coordinates(latitude: 14, longitude: 88);

  LocationUsecase sut;
  LocationRepository mockLocationRepository;

  setUp(() {
    mockLocationRepository = MockLocationRepository();
    sut = LocationUsecase(mockLocationRepository);
  });

  test('should get current position from repository', () async {
    when(mockLocationRepository.getPosition())
        .thenAnswer((_) async => Right(coordinates));
    final position = await sut();
    verify(mockLocationRepository.getPosition());
    expect(position, equals(Right<Failure, Coordinates>(coordinates)));
  });
}
