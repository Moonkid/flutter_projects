import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_exam_app_tdd/core/error/failure.dart';
import 'package:flutter_exam_app_tdd/core/strings.dart' as strings;
import 'package:flutter_exam_app_tdd/user/bloc/bloc.dart';
import 'package:flutter_exam_app_tdd/user/bloc/user_event.dart' as user_events;
import 'package:flutter_exam_app_tdd/user/data/models/user_model.dart';
import 'package:flutter_exam_app_tdd/user/usecases/fetch_random_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFetchRandomUser extends Mock implements FetchRandomUser {}

void main() {
  const user = UserModel(
      name: 'brad gibson',
      image: 'https://randomuser.me/api/portraits/men/75.jpg',
      latitude: 20.9267,
      longitude: -7.9310);

  FetchRandomUser randomUserUsecase;
  UserBloc bloc;
  setUp(() {
    randomUserUsecase = MockFetchRandomUser();
    bloc = UserBloc(usecase: randomUserUsecase);
  });

  test('initial state should be user_state.Initial when bloc created', () {
    expect(bloc.initialState, equals(const Initial()));
  });

  test('should get data from datasource', () async {
    when(randomUserUsecase()).thenAnswer((_) async => Right(user));
    bloc.add(user_events.Fetch());
    await untilCalled(randomUserUsecase());
    verify(randomUserUsecase());
  });

  blocTest<UserBloc, UserEvent, UserState>(
      'should emit [loading, loaded] when data is gotten]',
      build: () {
        when(randomUserUsecase()).thenAnswer((_) async => Right(user));
        return UserBloc(usecase: randomUserUsecase);
      },
      expect: const <UserState>[Initial(), Loading(), Loaded(user: user)],
      act: (bloc) {
        bloc.add(user_events.Fetch());
        return;
      });

  blocTest<UserBloc, UserEvent, UserState>(
      'should emit [loading, error] with proper message when getting data fails',
      build: () {
        when(randomUserUsecase())
            .thenAnswer((_) async => Left(ServerFailure()));
        return UserBloc(usecase: randomUserUsecase);
      },
      expect: <UserState>[
        const Initial(),
        const Loading(),
        Error(message: strings.serverFailureMessage)
      ],
      act: (bloc) {
        bloc.add(user_events.Fetch());
        return;
      });
}
