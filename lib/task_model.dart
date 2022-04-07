class TaskModel {
  final int id;
  final String task;
  int status; // -1 delete ; 0: none ; 1: successfull

  TaskModel({required this.id, required this.task, this.status = 0});

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json['id'],
        task: json['task'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() => {'id': id, 'task': task, 'status': status};
}
