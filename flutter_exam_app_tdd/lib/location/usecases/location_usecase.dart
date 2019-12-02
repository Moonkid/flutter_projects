import 'package:dartz/dartz.dart';
import 'package:flutter_exam_app_tdd/core/error/failure.dart';
import 'package:flutter_exam_app_tdd/core/usecases/usecase.dart';
import 'package:flutter_exam_app_tdd/location/domain/models/coordinates.dart';
import 'package:flutter_exam_app_tdd/location/domain/repositories/location_repository.dart';

class LocationUsecase extends Usecase<Coordinates> {
  LocationUsecase(
    LocationRepository repository,
  ) : _repository = repository;

  final LocationRepository _repository;

  @override
  Future<Either<Failure, Coordinates>> call() {
    return _repository.getPosition();
  }
}
