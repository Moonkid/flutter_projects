import 'package:flutter_exam_app_tdd/user/data/models/user_model.dart';

abstract class UserDatasource {
  const UserDatasource();

  Future<UserModel> fetchUser();
}