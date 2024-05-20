import 'package:QuickDo/core/storage/data_base_helper.dart';
import 'package:QuickDo/features/tasks/data/models/task_model.dart';
import 'package:QuickDo/features/tasks/data/models/to_do_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TaskController extends ChangeNotifier {


  List taskList = <Task>[].obs;

  Future <int> addTask({ Task? task}) {
    return DBHelper.insert(task);
  }

  Future<void> getTasks() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.addAll(tasks.map((data) => Task.fromJson(data)).toList());
    print('tasks list ${taskList}');
  }

  void deleteTasks(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  void deleteAllTasks() async {
    await DBHelper.deleteAll();
    getTasks();
  }

  void markUsCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}

