import 'package:flutter_exam_app_tdd/user/domain/models/user.dart';
import 'package:meta/meta.dart';

class UserModel extends User {
  const UserModel({
    @required String name,
    @required String image,
    @required double latitude,
    @required double longitude,
  }) : super(
            name: name, image: image, latitude: latitude, longitude: longitude);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name:
            '${json['results'][0]['name']['first']} ${json['results'][0]['name']['last']}',
        image: json['results'][0]['picture']['large'],
        latitude: double.tryParse(
                json['results'][0]['location']['coordinates']['latitude']) ??
            0,
        longitude: double.tryParse(
                json['results'][0]['location']['coordinates']['longitude']) ??
            0);
  }
}
