library usecases;

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_exam_app_tdd/core/error/failure.dart';
import 'package:flutter_exam_app_tdd/core/usecases/usecase.dart';
import 'package:flutter_exam_app_tdd/user/domain/models/user.dart';
import 'package:flutter_exam_app_tdd/user/domain/repositories/user_repository.dart';

class FetchRandomUser extends Usecase<User> {
  FetchRandomUser({
   @required UserRepository repository,
  }) : _repository = repository;

  final UserRepository _repository;

  @override
  Future<Either<Failure, User>> call() async {
    return await _repository.fetchRandomUser();
  }
}
