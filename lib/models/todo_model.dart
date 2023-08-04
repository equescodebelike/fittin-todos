import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TodoModel {
  final String? id;
  final String text;
  final DateTime? deadline;
  final bool done;
  final TextStyle? textStyle; // подумаю как реализовать по-другому

  TodoModel({
    this.id,
    required this.text,
    this.deadline,
    this.done = false,
    this.textStyle,
  });

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.text == text &&
        other.deadline == deadline &&
        other.done == done &&
        other.textStyle == textStyle;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        text.hashCode ^
        deadline.hashCode ^
        done.hashCode ^
        textStyle.hashCode;
  }

  TodoModel copyWith({
    String? id,
    String? text,
    DateTime? deadline,
    bool? done,
    TextStyle? textStyle,
  }) {
    return TodoModel(
      id: id ?? this.id,
      text: text ?? this.text,
      deadline: deadline ?? this.deadline,
      done: done ?? this.done,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}
