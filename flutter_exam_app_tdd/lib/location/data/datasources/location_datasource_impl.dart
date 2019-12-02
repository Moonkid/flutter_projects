//
// Created by Pavel Pozdniakov on 12/2/19.
// Copyright (c) 2019 SSA Group. All rights reserved.
//

import 'package:flutter_exam_app_tdd/core/error/exception.dart';
import 'package:flutter_exam_app_tdd/location/data/models/CoordinatesModel.dart';
import 'package:flutter_exam_app_tdd/location/domain/datasources/location_datasource.dart';
import 'package:flutter_exam_app_tdd/location/domain/models/coordinates.dart';
import 'package:geolocator/geolocator.dart';

class LocationDatasourceImpl extends LocationDatasource {
  LocationDatasourceImpl(
    Geolocator geolocator,
  ) : _geolocator = geolocator;

  Geolocator _geolocator;

  @override
  Future<Coordinates> getPosition() async {
    try {
      final position = await _geolocator.getCurrentPosition();
      return CoordinatesModel.fromPosition(position);
    } catch (_) {
      throw PositionException();
    }
  }
}
