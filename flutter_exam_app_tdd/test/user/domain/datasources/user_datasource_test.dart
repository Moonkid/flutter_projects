import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_exam_app_tdd/core/error/exception.dart';
import 'package:flutter_exam_app_tdd/user/data/datasources/remote_datasource.dart';
import 'package:flutter_exam_app_tdd/user/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';
import '../../../../fixtures/fixtures_reader.dart';


class MockHttpClient extends Mock implements http.Client {}

void main() {
  const user = UserModel(
      name: 'brad gibson',
      image: 'https://randomuser.me/api/portraits/men/75.jpg',
      latitude: 20.9267,
      longitude: -7.9310);

  RemoteDatasource datasource;
  MockHttpClient mockClient;

  setUp(() {
    mockClient = MockHttpClient();
    datasource = RemoteDatasource(client: mockClient);
  });

  test('should perform a GET request', () {
    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response(fixture('user.json'), 200));

    datasource.fetchUser();
    verify(mockClient.get('https://randomuser.me/api/1.3'));
  });

  test('should return a UserModel when status code is 200 (success)', () async {
    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response(fixture('user.json'), 200));

    final result = await datasource.fetchUser();
    expect(result, equals(user));
  });

  test('should throw a ServerException when status code is not 200 (failed)',
      () {
    when(mockClient.get(any))
        .thenAnswer((_) async => http.Response('Not Found', 404));
    expect(() => datasource.fetchUser(), throwsA(const TypeMatcher<ServerException>()));
  });
}
