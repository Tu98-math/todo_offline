import 'package:todo_offline/models/task_model.dart';

class ListTaskModel {
  final String id;
  final String name;
  List<TaskModel> listTask;

  ListTaskModel({required this.id, required this.name, required this.listTask});
}
