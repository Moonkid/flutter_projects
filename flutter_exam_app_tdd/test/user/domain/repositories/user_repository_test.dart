import 'package:dartz/dartz.dart';
import 'package:flutter_exam_app_tdd/core/error/exception.dart';
import 'package:flutter_exam_app_tdd/core/error/failure.dart';
import 'package:flutter_exam_app_tdd/user/data/models/user_model.dart';
import 'package:flutter_exam_app_tdd/user/data/repositories/random_user_repository.dart';
import 'package:flutter_exam_app_tdd/user/domain/datasources/user_datasource.dart';
import 'package:flutter_exam_app_tdd/user/domain/models/user.dart';
import 'package:flutter_exam_app_tdd/user/domain/repositories/user_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserDatasource extends Mock implements UserDatasource {}

void main() {
  UserDatasource mockDatasource;
  UserRepository repository;
  setUp(() {
    mockDatasource = MockUserDatasource();
    repository = RandomUserRepository(datasource: mockDatasource);
  });

  test(
      'user repository should return random user when datasource call is successful',
      () async {
    const user = UserModel(
        name: 'brad gibson',
        image: 'https://randomuser.me/api/portraits/men/75.jpg',
        latitude: 20.9267,
        longitude: -7.9310);

    when(mockDatasource.fetchUser()).thenAnswer((_) async => user);
    final result = await repository.fetchRandomUser();
    verify(mockDatasource.fetchUser());
    expect(result, equals(Right<Failure, User>(user)));
  });
  
  test('should return server failure when call to datasource is unsuccessful', () async {
    when(mockDatasource.fetchUser()).thenThrow(ServerException());
    final result = await repository.fetchRandomUser();
    verify(mockDatasource.fetchUser());
    expect(result, equals(Left<Failure, User>(ServerFailure())));
  });
}
