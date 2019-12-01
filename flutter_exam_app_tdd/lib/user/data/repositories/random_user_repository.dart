import 'package:dartz/dartz.dart';
import 'package:flutter_exam_app_tdd/core/error/exception.dart';
import 'package:flutter_exam_app_tdd/user/domain/datasources/user_datasource.dart';
import 'package:meta/meta.dart';
import 'package:flutter_exam_app_tdd/core/error/failure.dart';
import 'package:flutter_exam_app_tdd/user/domain/models/user.dart';
import 'package:flutter_exam_app_tdd/user/domain/repositories/user_repository.dart';

class RandomUserRepository implements UserRepository {
  const RandomUserRepository({
    @required UserDatasource datasource,
  }) : _datasource = datasource;

  final UserDatasource _datasource;

  @override
  Future<Either<Failure, User>> fetchRandomUser() async {
    try {
      final result = await _datasource.fetchUser();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
