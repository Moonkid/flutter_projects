import 'package:dating_app/details/screens/details_page.dart';
import 'package:dating_app/home/bloc/bloc.dart';
import 'package:dating_app/home/bloc/home_state.dart' as home_state;
import 'package:dating_app/home/bloc/home_event.dart' as home_events;
import 'package:dating_app/home/widgets/user_buttons.dart';
import 'package:dating_app/home/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Almost Tinder'),
      ),
      body: BlocProvider<HomeBloc>(
        builder: (context) => HomeBloc()..add(home_events.Fetch()),
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
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is home_state.Error) {
          return Center(child: Text(state.message));
        } else if (state is home_state.UserLoaded) {
          return UserCard(state.user);
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _buildButtons(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => UserButtons(
        onReload: () {
          BlocProvider.of<HomeBloc>(context).add(home_events.Fetch());
        },
        onNext: () {
          final state = BlocProvider.of<HomeBloc>(context).state;
          if (state is home_state.UserLoaded) {
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
