import 'package:fittin_todo/models/todo_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'add_page.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

TodoModel? note;

class _TodoListPageState extends State<TodoListPage> {
  final List<TodoModel> _todos = [];
  final _controller = TextEditingController();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  bool hidden = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        centerTitle: true,
        title: Text(
          'Мои дела',
          style: themeData.textTheme.headlineSmall?.copyWith(),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(53),
          child: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.all(17),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Выполнено - {кол-во done: true}
                // И Icon.visibility/off
                Text(
                  ('Выполнено - ${_todos.where((todo) => todo.done).length}'),
                  style: themeData.textTheme.bodyLarge
                      ?.copyWith(color: const Color(0xFFAEAEAE)),
                ),
                IconButton(
                  icon: Icon(hidden ? Icons.visibility_off : Icons.visibility),
                  color: themeData.primaryColor,
                  onPressed: () {
                    setState(() {
                      hidden = !hidden;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 17,
            vertical: 5,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                20,
              ),
            ),
          ),
          child: ListView.builder(
            itemCount: _todos.length,
            itemBuilder: (context, index) {
              if (_todos[index].done && hidden) {
                return const SizedBox.shrink();
              }
              // Dismissible done: true & removeAt()
              return Dismissible(
                background: Container(
                  color: themeData.colorScheme.secondary,
                  child: const Padding(
                    padding: EdgeInsets.all(11),
                    child: Row(
                      children: [
                        Icon(Icons.done, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                secondaryBackground: Container(
                  color: themeData.colorScheme.error,
                  child: const Padding(
                    padding: EdgeInsets.all(11),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.delete, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                key: UniqueKey(),
                onDismissed: (DismissDirection direction) {
                  if (direction == DismissDirection.endToStart) {
                    setState(() {
                      _todos.removeAt(index);
                    });
                  } else if (direction == DismissDirection.startToEnd) {
                    setState(() {
                      _todos[index] = _todos[index].copyWith(
                        done: true,
                      );
                    });
                  }
                },
                child: GestureDetector(
                  onLongPress: () async {
                    note = TodoModel(
                        text: _todos[index].text,
                        deadline: _todos[index].deadline);
                    navigateToAddPage();
                    setState(() {
                      _todos.removeAt(index); // не успел :(
                    });
                  },
                  child: CheckboxListTile(
                      activeColor: themeData.colorScheme.secondary,
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _todos[index].done,
                      onChanged: (value) {
                        null;
                      },
                      // Заметки и даты под ними
                      title: Text(
                        _todos[index].text,
                        style: _todos[index].done
                            ? _todos[index].textStyle?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: const Color(0xFFAEAEAE),
                                )
                            : _todos[index].textStyle,
                      ),
                      subtitle: _todos[index].deadline != null
                          ? Text(
                              dateFormat
                                  .format(_todos[index].deadline!)
                                  .toString(),
                              style: themeData.textTheme.bodyMedium,
                            )
                          : Text(
                              'Дата',
                              style: themeData.textTheme.bodyMedium,
                            )),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          navigateToAddPage();
        },
        backgroundColor: themeData.primaryColor,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void saveNewToDo() {
    setState(() {
      _todos.add(TodoModel(
        text: _controller.text.isNotEmpty ? _controller.text : 'Заметка',
        deadline: datePick,
        textStyle: Theme.of(context).textTheme.bodyLarge,
      ));
      _controller.clear();
    });
  }

  void navigateToAddPage() {
    final route = MaterialPageRoute(
      builder: (context) => AddPage(
        controller: _controller,
        onSave: saveNewToDo,
      ),
    );
    Navigator.push(context, route);
  }
}
