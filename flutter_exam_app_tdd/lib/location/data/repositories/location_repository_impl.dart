import 'package:dartz/dartz.dart';
import 'package:flutter_exam_app_tdd/core/error/exception.dart';
import 'package:flutter_exam_app_tdd/core/error/failure.dart';
import 'package:flutter_exam_app_tdd/core/utils/permissions_manager.dart';
import 'package:flutter_exam_app_tdd/location/domain/datasources/location_datasource.dart';
import 'package:flutter_exam_app_tdd/location/domain/models/coordinates.dart';
import 'package:flutter_exam_app_tdd/location/domain/repositories/location_repository.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:meta/meta.dart';

class LocationRepositoryImpl extends LocationRepository {
  const LocationRepositoryImpl({
    @required LocationDatasource datasource,
    @required PermissionsManager permissionsManager,
  })  : _datasource = datasource,
        _permissionsManager = permissionsManager;

  final LocationDatasource _datasource;
  final PermissionsManager _permissionsManager;

  @override
  Future<Either<Failure, Coordinates>> getPosition() async {
    final status = await _permissionsManager.permissionStatus();
    if (status != PermissionStatus.granted) {
      final permissionStatus = await _permissionsManager.requestPermissions();
      if (permissionStatus != PermissionStatus.granted) {
        return Left(PermissionFailure());
      }
    }
    try {
      final result = await _datasource.getPosition();
      return Right(result);
    } on PositionException {
      return Left(PositionFailure());
    }
  }
}
