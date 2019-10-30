import 'package:flutter/material.dart';
import 'package:lecture_2_todos/models/todo.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final _textController = TextEditingController();
  final List<Todo> _todos = <Todo>[];

  @override
  void initState() {
    super.initState();
    _todos.addAll(
        [
          const Todo(text: 'Press "+" to add a note.'),
          const Todo(text: 'Swipe to the left to delete note'),
          const Todo(text: 'Swipe to the right to mark note as finished'),
        ]
    );

    _textController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          '//TODO:',
          style: TextStyle(color: Colors.lightGreen),
        ),
      ),
      body: Column(
        children: <Widget>[
          _listViewOrHint(),
          _buildDivider(),
          _bottomActionBar()
        ],
      ),
    );
  }

  Widget _listViewOrHint() {
    return _todos.isEmpty
        ? const Expanded(
            child: Center(child: Text('Press "+" to add your first note.')),
          )
        : _listView();
  }

  Widget _listView() {
    return Expanded(
      child: ListView.builder(
          itemCount: _todos.length,
          itemBuilder: (context, i) {
            return _buildDismissibleTile(index: i);
          }),
    );
  }

  Dismissible _buildDismissibleTile({int index}) {
    final todo = _todos[index];
    Widget _primaryBackground() {
      return Container(
        alignment: Alignment.centerLeft,
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Icon(Icons.check),
        ),
      );
    }

    Widget _secondaryBackground() {
      return Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Icon(Icons.delete_outline),
        ),
      );
    }

    Widget _todoTile(Todo todo) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          ListTile(
            title: Text(
              todo.text,
              style: todo.isFinished
                  ? TextStyle(decoration: TextDecoration.lineThrough)
                  : null,
            ),
          ),
          _buildDivider()
        ],
      );
    }

    Future<bool> _confirmAction(DismissDirection direction) {
      if (direction == DismissDirection.startToEnd) {
        setState(() {
          _markFinished(todo, index);
        });
      }
      return Future.value(direction == DismissDirection.endToStart);
    }

    void _onDismissed(DismissDirection direction) {
      setState(() {
        _todos.removeAt(index);
        _scaffoldKey.currentState
          ..removeCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Deleted \"${todo.text}\"'),
              action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () => setState(
                        () => _todos.insert(index, todo),
                      ) // this is what you needed
                  ),
            ),
          );
      });
    }

    return Dismissible(
      background: _primaryBackground(),
      secondaryBackground: _secondaryBackground(),
      confirmDismiss: _confirmAction,
      onDismissed: _onDismissed,
      key: Key(UniqueKey().toString()),
      child: _todoTile(todo),
    );
  }

  void _markFinished(Todo todo, int index) {
    _todos.removeAt(index);
    _todos.insert(index, todo.copyWith(isFinished: !todo.isFinished));
  }

  Divider _buildDivider() {
    return const Divider(
      height: 1,
      color: Colors.white54,
    );
  }

  Widget _bottomActionBar() {
    void addNewItem() {
      setState(() {
        final todo = Todo(text: _textController.text);
        _todos.add(todo);
        _textController.clear();
      });
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: _buildExpandableTextField(),
          ),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: _textController.text.isNotEmpty ? addNewItem : null,
        )
      ],
    );
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
                hintText: 'Take a note...',
                hintStyle: TextStyle(color: Colors.white54)),
            controller: _textController,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _textController.dispose();
    super.dispose();
  }
}
