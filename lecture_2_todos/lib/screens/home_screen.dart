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
        children: <Widget>[
          Expanded(child: _listView()),
          const Divider(
            height: 1,
            color: Colors.white54,
          ),
          _bottomActionBar()
        ],
      ),
    );
  }

  Widget _listView() {
    return ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, i) {
          return _buildTile(i);
        });
  }

  Widget _buildTile(int i) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        ListTile(
          title: Text(_todos[i]),
        ),
        const Divider(
          height: 1,
          color: Colors.white54,
        )
      ],
    );
  }

  Widget _bottomActionBar() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: _buildExpandableTextField(),
            ),
          ),
          FlatButton(
            child: const Text('Add'),
            onPressed: addNewItem,
          )
        ],
      );

  void addNewItem() {
    setState(() {
      _todos.add(_textController.text);
      _textController.clear();
    });
  }

  Widget _buildExpandableTextField() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 150),
      child: Scrollbar(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: true,
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration.collapsed(
                hintText: 'New note',
                hintStyle: TextStyle(color: Colors.white54)),
            controller: _textController,
          ),
        ),
      ),
    );
  }
}
