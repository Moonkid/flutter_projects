library home_state;

import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import '../../models/user.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class Loading extends HomeState {}

class Initial extends HomeState {}

class Error extends HomeState {
  const Error({
    @required this.message,
  });

  final String message;
}

class UserLoaded extends HomeState {
  const UserLoaded(
    this.user,
  );

  final User user;
}
