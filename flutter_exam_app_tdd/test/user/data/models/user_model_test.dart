import 'dart:convert';
import 'package:flutter_exam_app_tdd/user/data/models/user_model.dart';
import 'package:flutter_exam_app_tdd/user/domain/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixtures_reader.dart';

void main() {
  const user = UserModel(
      name: 'brad gibson',
      image: 'https://randomuser.me/api/portraits/men/75.jpg',
      latitude: 20.9267,
      longitude: -7.9310);

  test('should be a subclass of user', () {
    expect(user, isA<User>());
  });

  group('fromJson', () {
    test('should return a valid user model when json is provided', () {
      final jsonString = fixture('user.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      final result = UserModel.fromJson(jsonMap);

      expect(result, user);
    });
  });
}
