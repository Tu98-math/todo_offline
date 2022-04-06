class TaskModel {
  final String id;
  final String task;
  final bool checked;

  TaskModel({required this.id, required this.task, this.checked = false});

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        task: json['task'],
        checked: json['checked'],
      );

  Map<String,dynamic> toJson() => {
    'id': id,
    'task': task,
    'checked': checked
  };
}
