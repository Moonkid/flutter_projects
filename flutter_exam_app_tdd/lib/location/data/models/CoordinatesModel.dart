//
// Created by Pavel Pozdniakov on 12/2/19.
// Copyright (c) 2019 SSA Group. All rights reserved.
//

import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:flutter_exam_app_tdd/location/domain/models/coordinates.dart';

class CoordinatesModel extends Coordinates {
  const CoordinatesModel({
    @required double latitude,
    @required double longitude,
  }) : super(latitude: latitude, longitude: longitude);

  factory CoordinatesModel.fromPosition(Position position) {
    return CoordinatesModel(
        latitude: position.latitude, longitude: position.longitude);
  }
}
