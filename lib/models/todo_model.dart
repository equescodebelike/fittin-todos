import 'package:flutter/material.dart';

class TodoModel {
  final String text;
  final DateTime? deadline;
  final bool done;
  final TextStyle? textStyle; // подумаю как реализовать по-другому

  TodoModel({
    required this.text,
    this.deadline,
    this.done = false,
    this.textStyle,
  });

  TodoModel copyWith({
    String? text,
    DateTime? deadline,
    bool? done,
    TextStyle? textStyle,
  }) {
    return TodoModel(
      text: text ?? this.text,
      deadline: deadline ?? this.deadline,
      done: done ?? this.done,
      textStyle: textStyle ?? this.textStyle,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModel &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          deadline == other.deadline &&
          done == other.done;

  @override
  int get hashCode => text.hashCode ^ deadline.hashCode ^ done.hashCode;
}
