import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'task_item.dart';
import 'task_model.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<TaskModel> tasks = [];
  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    readTask();
  }

  void writeTask() {
    box.write('task_length', tasks.length);
    for (int i = 0; i < tasks.length; i++) {
      box.write('task_$i', tasks[i].toJson);
    }
  }

  void readTask() {
    int? taskLength = box.read('task_length');
    if (taskLength != null) {
      tasks.clear();
      for (int i = 0; i < taskLength; i++) {
        var temp = TaskModel.fromJson(box.read('task_$i'));
        tasks.add(temp);
      }
      setState(() {});
    }
  }

  void successfulTask(TaskModel task) {
    setState(() {
      if (task.status == 0) {
        task.status = 1;
      }
    });
    box.write('task_${task.id}', task.toJson());
  }

  void addTask(String task) {
    TaskModel temp = TaskModel(id: tasks.length, task: task);
    setState(() {
      tasks.add(temp);
    });
    _controller.text = '';
    box.write('task_${tasks.length - 1}', temp.toJson());
    box.write('task_length', tasks.length);
  }

  void deleteTask(TaskModel task) {
    setState(() {
      task.status = -1;
    });
    box.write('task_${task.id}', task.toJson());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) => TaskItem(
              task: tasks[index],
              pressSuccessful: () => successfulTask(tasks[index]),
              pressDelete: () => deleteTask(tasks[index]),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTask,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _showAddTask() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tạo task mới'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: ListBody(
                children: <Widget>[
                  const Text('Nhập task của bạn'),
                  TextFormField(
                    controller: _controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập task của bạn';
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Thêm'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  addTask(_controller.text);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
