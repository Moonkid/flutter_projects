import 'package:flutter/material.dart';
import 'package:lecture_3_cats/pages/home_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cats Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'BadBlackCat',
      ),
      home: HomePage(),
    );
  }
}
