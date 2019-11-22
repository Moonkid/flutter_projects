import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import '../../models/user.dart';
import 'bloc.dart';
import 'home_event.dart' as home_event;
import 'home_state.dart' as home_state;

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => home_state.Initial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is home_event.Fetch) {
      yield* _mapFetchEventToState();
    }
  }

  Stream<HomeState> _mapFetchEventToState() async* {
    yield home_state.Loading();
    try {
      final uri = Uri.https('randomuser.me', '/api/1.3');
      final response = await http.get(uri);
      final Map<String, dynamic> parsed = json.decode(response.body);
      final user = User.fromRandomUserResponse(parsed);
      yield home_state.UserLoaded(user);
    } catch (_) {
      yield const home_state.Error(message: 'Failed fetching user');
    }
  }
}
