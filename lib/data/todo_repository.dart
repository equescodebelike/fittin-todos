import 'package:fittin_todo/models/todo_model.dart';
import 'package:uuid/uuid.dart';

class TodoRepository {
  static TodoRepository? _instance;

  factory TodoRepository() {
    return _instance ??= TodoRepository._();
  }

  final Map<String, TodoModel> _storage = {};

  List<TodoModel> getAll() => _storage.values.toList();

  List<TodoModel> getUnChecked() =>
      _storage.values.where((todo) => !todo.done).toList();

  TodoModel save(TodoModel todoModel) {
    final todo = todoModel.id == null
        ? todoModel.copyWith(
            id: const Uuid().v4(),
          )
        : todoModel;
    _storage[todo.id!] = todo;
    return todo;
  }

  TodoModel? remove(TodoModel todoModel) {
    return _storage.remove(todoModel.id);
  }
}
