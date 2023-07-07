import 'package:flutter_todo/src/controller/todo_controller.dart';
import 'package:get/get.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(TodoController());
  }
}
