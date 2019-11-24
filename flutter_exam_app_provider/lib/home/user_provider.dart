import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_exam_app_provider/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

enum HomeStatus { undefined, loading, loaded, error }

class UserProvider with ChangeNotifier {
  User user;
  String error;

  HomeStatus status = HomeStatus.undefined;

  Future<void> fetchUser() async {
    user = null;
    error = null;

    status = HomeStatus.loading;
    notifyListeners();

    try {
      user = await _generateUser();
      status = HomeStatus.loaded;
      notifyListeners();
    } catch (_) {
      error = 'Something is wrong. Check your internet connection. :-(';
    }
  }

  Future<User> _generateUser() async {
    final uri = Uri.https('randomuser.me', '/api/1.3');
    final response = await http.get(uri);
    return compute(_parseUser, response.body);
  }

  static User _parseUser(String response) {
    final Map<String, dynamic> parsed = json.decode(response);
    return User.fromRandomUserResponse(parsed);
  }
}
