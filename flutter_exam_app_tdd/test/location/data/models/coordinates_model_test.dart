//
// Created by Pavel Pozdniakov on 12/2/19.
// Copyright (c) 2019 SSA Group. All rights reserved.
//

import 'package:flutter_exam_app_tdd/location/data/models/CoordinatesModel.dart';
import 'package:flutter_exam_app_tdd/location/domain/models/coordinates.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  const model = CoordinatesModel(latitude: 0, longitude: 0);
  test('should be a subclass of Coordinates', () {
    expect(model, isA<Coordinates>());
  });

  test('should return a valid coordinate model from valid Position obj', () {
    final res =
        CoordinatesModel.fromPosition(Position(latitude: 0, longitude: 0));
    expect(res, model);
  });
}
