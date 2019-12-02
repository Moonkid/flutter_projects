//
// Created by Pavel Pozdniakov on 12/2/19.
// Copyright (c) 2019 SSA Group. All rights reserved.
//

import 'package:flutter_exam_app_tdd/location/domain/models/coordinates.dart';
import 'package:latlong/latlong.dart';

int distance({Coordinates from, Coordinates to}) {
  final km = const Distance().as(LengthUnit.Kilometer,
      LatLng(from.latitude, from.longitude), LatLng(to.latitude, to.longitude));
  return km.toInt();
}
