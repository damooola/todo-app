import 'package:flutter/material.dart';
import 'package:todoapp/util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// text controller

  final _dialogBoxController = TextEditingController();

  //list of todo items
  List todoList = [
    ['Make tutorials', false],
    ['Do chores', true],
    ['Read Bible', true]
  ];

// when checkbox is tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  //save new task
  void saveNewTask() {
    setState(() {
      todoList.add([_dialogBoxController.text, false]);
    });
    _dialogBoxController.clear();
    Navigator.of(context).pop();
  }

// create new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          dialogBoxController: _dialogBoxController,
          onSave: saveNewTask,
          onCancel:
              // pop off the dialog box
              Navigator.of(context).pop,
        );
      },
    );
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('TO DO LIST'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: todoList[index][0],
            taskComplete: todoList[index][1],
            onChanged: (value) {
              checkBoxChanged(value, index);
            },
            onDelete: (context) {
              deleteTask(index);
            },
          );
        },
        itemCount: todoList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
