import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  const User({
    @required this.name,
    @required this.image,
    @required this.longitude,
    @required this.latitude,
  });

  final String name;
  final String image;
  final double latitude;
  final double longitude;

  @override
  List<Object> get props => [name, image, latitude, longitude];
}
