import 'package:dartz/dartz.dart';
import 'package:flutter_exam_app_tdd/core/error/failure.dart';

abstract class Usecase<Type> {
  Future<Either<Failure, Type>> call();
}