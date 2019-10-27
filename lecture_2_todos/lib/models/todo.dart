import 'package:meta/meta.dart';

class Todo {
  const Todo({
    @required this.text,
    this.isFinished = false,
  });

  final String text;
  final bool isFinished;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todo &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          isFinished == other.isFinished);

  @override
  int get hashCode => text.hashCode ^ isFinished.hashCode;

  Todo copyWith({
    String text,
    bool isFinished,
  }) {
    return Todo(
      text: text ?? this.text,
      isFinished: isFinished ?? this.isFinished,
    );
  }

//</editor-fold>
}
