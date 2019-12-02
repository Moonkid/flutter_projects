import 'package:dartz/dartz.dart';
import 'package:flutter_exam_app_tdd/core/error/failure.dart';
import 'package:flutter_exam_app_tdd/location/domain/models/coordinates.dart';

abstract class LocationRepository {
  const LocationRepository();

  Future<Either<Failure, Coordinates>> getPosition();
}
