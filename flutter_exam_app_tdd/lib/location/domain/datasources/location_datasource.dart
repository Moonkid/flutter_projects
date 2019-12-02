import 'package:flutter_exam_app_tdd/location/domain/models/coordinates.dart';

abstract class LocationDatasource {
  Future<Coordinates> getPosition();
}