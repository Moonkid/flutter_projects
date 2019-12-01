import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exam_app_tdd/user/bloc/bloc.dart';
import 'package:flutter_exam_app_tdd/user/bloc/user_event.dart' as user_events;
import 'package:flutter_exam_app_tdd/user/bloc/user_state.dart' as user_states;
import 'package:flutter_exam_app_tdd/user/data/datasources/remote_datasource.dart';
import 'package:flutter_exam_app_tdd/user/data/repositories/random_user_repository.dart';
import 'package:flutter_exam_app_tdd/user/presentation/screens/details_page.dart';
import 'package:flutter_exam_app_tdd/user/presentation/widgets/user_buttons.dart';
import 'package:flutter_exam_app_tdd/user/presentation/widgets/user_card.dart';
import 'package:flutter_exam_app_tdd/user/usecases/fetch_random_user.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Almost Tinder'),
      ),
      body: BlocProvider<UserBloc>(
        create: (_) {
          final bloc = UserBloc(
              usecase: FetchRandomUser(
                  repository: RandomUserRepository(
                      datasource: RemoteDatasource(client: http.Client()))));
          bloc.add(user_events.Fetch());
          return bloc;
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[_buildUserCard(), _buildButtons(context)],
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard() {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is user_states.Error) {
          return Center(child: Text(state.message));
        } else if (state is user_states.Loaded) {
          return UserCard(state.user);
        }
        return const Padding(
          padding: EdgeInsets.all(150.0),
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildButtons(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) =>
          UserButtons(
            onReload: () {
              BlocProvider.of<UserBloc>(context).add(user_events.Fetch());
            },
            onNext: () {
              final state = BlocProvider
                  .of<UserBloc>(context)
                  .state;
              if (state is user_states.Loaded) {
                Navigator.of(context).push<void>(
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(user: state.user),
                  ),
                );
              }
            },
          ),
    );
  }
}
