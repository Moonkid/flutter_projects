
import 'package:dartz/dartz.dart';
import 'package:flutter_exam_app_tdd/core/error/failure.dart';
import 'package:flutter_exam_app_tdd/user/domain/models/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> fetchRandomUser();
}