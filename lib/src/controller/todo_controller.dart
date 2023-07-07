import 'package:flutter/material.dart';
import 'package:flutter_todo/src/data/model/todo_model.dart';
import 'package:flutter_todo/src/data/provider/firebase_db.dart';
import 'package:flutter_todo/src/data/repository/todo_repository.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  final Rx<List<TodoModel>> _todos = Rx<List<TodoModel>>([]);
  final TextEditingController _controller = TextEditingController();

  List<TodoModel> get todos => _todos.value;
  TextEditingController get createController => _controller;

  @override
  void onReady() {
    super.onReady();
    _todos.bindStream(TodoRepository.fetchTodos());
  }

  void create() {
    final todo = _controller.value.text;
    if (todo.isNotEmpty) {
      try {
        final todoModel = TodoModel.toJson(todo);
        todoApi.createTodo(todoModel);
        _controller.clear();
      } catch (e) {
        debugPrint("Error");
      }
    }
  }

  void updateTodo(String id) {
    try {
      todoApi.updateTodo(id);
    } catch (e) {
      debugPrint("Error");
    }
  }

  void deleteTodo(String id) {
    try {
      todoApi.deleteTodo(id);
    } catch (e) {
      debugPrint("Error");
    }
  }
}
