import 'package:flutter/material.dart';

import 'task_model.dart';

class TaskItem extends StatelessWidget {
  const TaskItem(
      {Key? key,
      required this.task,
      required this.pressSuccessful,
      required this.pressDelete})
      : super(key: key);

  final TaskModel task;
  final Function pressSuccessful;
  final Function pressDelete;

  @override
  Widget build(BuildContext context) {
    return task.status != -1
        ? InkWell(
            onTap: () => pressSuccessful(),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    task.status == 0 ? Icons.circle_outlined : Icons.task_alt,
                  ),
                ),
                Expanded(
                  child: Text(
                    task.task,
                    style: TextStyle(
                      decoration:
                          task.status == 0 ? null : TextDecoration.lineThrough,
                      color: task.status == 0 ? Colors.black : Colors.black54,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => pressDelete(),
                  icon: const Icon(Icons.delete_outline_sharp),
                  color: Colors.red,
                )
              ],
            ),
          )
        : const SizedBox();
  }
}
