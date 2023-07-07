import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_todo/src/constants/firebase_const.dart';
import 'package:flutter_todo/src/data/model/todo_model.dart';

class todoApi {
  static Stream<List<TodoModel>> getTodos() {
    return firebaseFirestore
        .collection('todo')
        .snapshots()
        .map((QuerySnapshot query) {
      List<TodoModel> todos = [];
      for (var doc in query.docs) {
        final todoModel = TodoModel.froJson(doc);
        todos.add(todoModel);
      }
      return todos;
    });
  }

  static Future<void> createTodo(TodoModel todoModel) {
    return firebaseFirestore.collection('todo').doc().set(
      {
        'todo': todoModel.todo,
        'time': Timestamp.now(),
        'isDone': false,
      },
    );
  }

  static void updateTodo(String id) {
    firebaseFirestore.collection('todo').doc(id).update(
      {
        'isDone': true,
      },
    );
  }

  static void deleteTodo(String id) {
    firebaseFirestore.collection('todo').doc(id).delete();
  }
}
