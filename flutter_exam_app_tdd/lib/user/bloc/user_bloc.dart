import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_exam_app_tdd/core/error/failure.dart';
import 'package:flutter_exam_app_tdd/core/strings.dart' as strings;
import 'package:flutter_exam_app_tdd/core/usecases/usecase.dart';
import 'package:flutter_exam_app_tdd/user/domain/models/user.dart';
import 'package:meta/meta.dart';
import './bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({
    @required Usecase usecase,
  }) : _usecase = usecase;

  final Usecase _usecase;

  @override
  UserState get initialState => const Initial();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is Fetch) {
      yield const Loading();
      final Either<Failure, User> result = await _usecase();
      final state = result.fold(
          (failure) => Error(message: strings.mapFailureToMessage(failure)),
          (user) => Loaded(user: user));
      yield state;
    }
  }
}
