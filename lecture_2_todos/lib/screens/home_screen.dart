import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textController = TextEditingController();
  final List<String> _todos = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ToDoS'),
      ),
      body: Column(
        children: <Widget>[Expanded(child: _listView()), Container(height: 50, child: _bottomActionBar())],
      ),
    );
  }

  Widget _listView() {
    return ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(_todos[i]),
          );
        });
  }

  Widget _bottomActionBar() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textController,
            ),
          ),
          FlatButton(
            child: const Text('Add'),
            onPressed: () {
              setState(() {
                _todos.add(_textController.text);
              });
            },
          )
        ],
      );
}
