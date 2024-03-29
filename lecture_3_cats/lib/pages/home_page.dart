import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lecture_3_cats/widgets/cat_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _images = [
    'resources/cat-1.jpeg',
    'resources/cat-2.jpeg',
    'resources/cat-3.jpeg',
    'resources/cat-4.jpeg',
    'resources/cat-5.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    AppBar buildAppBar() {
      return AppBar(
        title: const Text(
          'Cats',
          style: TextStyle(fontSize: 28),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addNewItemAction,
          )
        ],
      );
    }

    return Scaffold(
      appBar: buildAppBar(),
      body: GridView.builder(
          itemCount: _images.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: _builder),
    );
  }

  Widget _builder(BuildContext context, int index) {
    final imageUrl = _images[index];

    return CatItem(index: index, imageUrl: imageUrl);
  }

  void _addNewItemAction() {
    http.get('http://aws.random.cat/meow').then((response) {
      setState(() {
        final Map<String, dynamic> result = json.decode(response.body);
        _images.insert(0, result['file']);
      });
    });
  }
}
