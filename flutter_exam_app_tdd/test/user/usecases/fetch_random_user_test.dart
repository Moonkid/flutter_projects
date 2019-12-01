
import 'package:dartz/dartz.dart';
import 'package:flutter_exam_app_tdd/core/error/failure.dart';
import 'package:flutter_exam_app_tdd/user/domain/models/user.dart';
import 'package:flutter_exam_app_tdd/user/domain/repositories/user_repository.dart';
import 'package:flutter_exam_app_tdd/user/usecases/fetch_random_user.dart' as usecases;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';


class MockUserRepository extends Mock implements UserRepository {}

void main() {
  final mockRepository = MockUserRepository();
  final sut = usecases.FetchRandomUser(repository: mockRepository);

  const user = User(
      name: 'brad gibson',
      image: 'https://randomuser.me/api/portraits/men/75.jpg',
      latitude: 20.9267,
      longitude: -7.9310);
  
  test('should return random user from mockRepository', () async {
    when(mockRepository.fetchRandomUser()).thenAnswer((_) async => Right(user));
    final result = await sut();
    expect(result, Right<Failure, User>(user));
    verify(mockRepository.fetchRandomUser());
    verifyNoMoreInteractions(mockRepository);
  });
}