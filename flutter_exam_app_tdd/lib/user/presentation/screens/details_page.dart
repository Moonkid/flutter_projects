import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exam_app_tdd/core/utils/location_utils.dart';
import 'package:flutter_exam_app_tdd/core/utils/permissions_manager.dart';
import 'package:flutter_exam_app_tdd/location/data/datasources/location_datasource_impl.dart';
import 'package:flutter_exam_app_tdd/location/data/repositories/location_repository_impl.dart';
import 'package:flutter_exam_app_tdd/location/usecases/location_usecase.dart';
import 'package:flutter_exam_app_tdd/user/domain/models/user.dart';
import 'package:flutter_exam_app_tdd/location/bloc/bloc.dart';
import 'package:flutter_exam_app_tdd/location/bloc/location_event.dart'
    as location_events;
import 'package:flutter_exam_app_tdd/location/bloc/location_state.dart'
    as location_states;
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key key, this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: BlocProvider<LocationBloc>(
        create: (context) => LocationBloc(
            usecase: LocationUsecase(LocationRepositoryImpl(
                datasource: LocationDatasourceImpl(Geolocator()),
                permissionsManager:
                    PermissionsManagerImpl(LocationPermissions()))))
          ..add(location_events.GetCurrentPosition()),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Hero(
            tag: 'avatar',
            child: Image.network(
              user.image,
              fit: BoxFit.fill,
              height: 400,
              width: 400,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildDistance(),
          ),
        ],
      ),
    );
  }

  Widget _buildDistance() {
    return BlocBuilder<LocationBloc, LocationState>(builder: (context, state) {
      if (state is location_states.Updated) {
        return Text(
          '${user.name} is ${distance(from: state.position, to: user.position)} km away from you!',
          style: Theme.of(context).textTheme.headline,
        );
      } else if (state is location_states.Error) {
        return Text(
          state.message,
          style: Theme.of(context).textTheme.headline,
        );
      } else {
        return const CircularProgressIndicator();
      }
    });
  }
}
