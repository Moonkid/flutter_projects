import 'package:flutter_exam_app_provider/home/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exam_app_provider/models/user.dart';
import 'package:flutter_exam_app_provider/details/details_page.dart';
import 'package:flutter_exam_app_provider/widgets/user_buttons.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Almost Tinder'),
      ),
      body: Center(
        child: ChangeNotifierProvider<UserProvider>(
          builder: (context) => UserProvider()..fetchUser(),
          child: _buildHome(context),
        ),
      ),
    );
  }

  Widget _buildHome(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, provider, _) {
        if (provider.status == HomeStatus.error) {
          return Text(provider.error);
        } else if (provider.status == HomeStatus.loaded) {
          return _buildUser(context, user: provider.user);
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _buildUser(BuildContext context, {@required User user}) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'avatar',
            child: Image.network(
              user.image,
              fit: BoxFit.fill,
              height: 300,
              width: 300,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              user.name,
              style: Theme.of(context).textTheme.display1,
            ),
          ),
          UserButtons(
            onReload: () {
              Provider.of<UserProvider>(context, listen: false).fetchUser();
            },
            onNext: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (context) => DetailsPage(user: user),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
