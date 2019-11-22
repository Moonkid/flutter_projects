import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exam_app_bloc/models/user.dart';
import 'package:flutter_exam_app_bloc/details/bloc/bloc.dart';
import 'package:flutter_exam_app_bloc/details/bloc/distance_event.dart'
    as user_events;
import 'package:flutter_exam_app_bloc/details/bloc/distance_state.dart'
    as user_states;

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key key, this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
      body: BlocProvider<DistanceBloc>(
        builder: (context) =>
            DistanceBloc(user: user)..add(user_events.CalculateDistance()),
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
    return BlocBuilder<DistanceBloc, DistanceState>(builder: (context, state) {
      if (state is user_states.DistanceCalculated) {
        return Text(
          '${user.name} is ${state.distance} km away from you!',
          style: Theme.of(context).textTheme.headline,
        );
      } else if (state is user_states.Error) {
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
