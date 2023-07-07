import 'package:flutter/material.dart';
import 'package:flutter_todo/src/controller/todo_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class App extends GetView<TodoController> {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Obx(
        () => Column(
          children: [
            _create(),
            _todoList(),
          ],
        ),
      ),
    );
  }

  Widget _create() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.createController,
              decoration: InputDecoration(
                hintText: 'Enter a task',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: controller.create,
            child: const Icon(Icons.send),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _todoList() {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.todos.length,
        itemBuilder: (context, index) {
          final todoModel = controller.todos[index];
          final milliseconds = todoModel.time!.millisecondsSinceEpoch;
          final dateTime = DateTime.fromMillisecondsSinceEpoch(milliseconds);

          return ListTile(
            leading: GestureDetector(
              onTap: () {
                if (todoModel.isDone!) {
                  controller.deleteTodo(todoModel.id!);
                } else {
                  controller.updateTodo(todoModel.id!);
                }
              },
              child: Icon(
                todoModel.isDone! ? Icons.check : Icons.close,
                color: todoModel.isDone! ? Colors.green : Colors.red,
              ),
            ),
            title: Text(
              todoModel.todo,
              style: TextStyle(
                decoration: todoModel.isDone!
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            subtitle: Text(DateFormat('yyyy-MM-dd HH:mm').format(dateTime)),
          );
        },
      ),
    );
  }
}
