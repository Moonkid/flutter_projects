library user_states;

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_exam_app_tdd/user/domain/models/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class Initial extends UserState {
  const Initial();
}

class Loading extends UserState {
  const Loading();
}

class Loaded extends UserState {
  const Loaded({
    @required this.user,
  });

  final User user;
}

class Error extends UserState {
  const Error({
    @required this.message,
  });

  final String message;
  @override
  List<Object> get props => [message];
}