import 'dart:convert';

import 'package:flutter_exam_app_tdd/core/error/exception.dart';
import 'package:flutter_exam_app_tdd/user/data/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_exam_app_tdd/user/domain/datasources/user_datasource.dart';

class RemoteDatasource extends UserDatasource {
  const RemoteDatasource({
    @required http.Client client,
  }) : _client = client;

  final http.Client _client;

  @override
  Future<UserModel> fetchUser() async {
    final result = await _client.get('https://randomuser.me/api/1.3');
    if (result.statusCode == 200) {
      return UserModel.fromJson(json.decode(result.body));
    } else {
      throw ServerException();
    }
  }
}
