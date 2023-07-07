import 'package:flutter_todo/src/data/model/todo_model.dart';
import 'package:flutter_todo/src/data/provider/firebase_db.dart';

class TodoRepository {
  static Stream<List<TodoModel>> fetchTodos() => todoApi.getTodos();
}
