import 'package:flutter_exam_app_tdd/core/utils/permissions_manager.dart';
import 'package:flutter_exam_app_tdd/location/datasources/location_datasource.dart';
import 'package:flutter_exam_app_tdd/location/domain/repositories/location_repository.dart';
import 'package:meta/meta.dart';

class LocationRepositoryImpl extends LocationRepository {
  const LocationRepositoryImpl({
    @required LocationDatasource datasource,
    @required PermissionsManager permissionsManager,
  })
      : _datasource = datasource,
        _permissionsManager = permissionsManager;

  final LocationDatasource _datasource;
  final PermissionsManager _permissionsManager;
}