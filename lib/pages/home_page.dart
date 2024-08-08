import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/util/dialog_box.dart';
import '../util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// reference the box
  final _myBox = Hive.box("myBox");

// initialise ToDoDataBase
  final db = ToDoDataBase();

  @override
  void initState() {
// if first time ever opening opening app then create default data
if(_myBox.get("TODOLIST")== null){
  db.createInitialData();
} else{
  // there already exists data
  db.loadData();
}


    super.initState();
  }

// text controller
  final _dialogBoxController = TextEditingController();

// when checkbox is tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });

    db.updateDataBase();
  }

// save new task
  void saveNewTask() {
    setState(() {
      db.todoList.add([_dialogBoxController.text, false]);
    });
    _dialogBoxController.clear();
    Navigator.of(context).pop();
    db.updateDataBase();
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
      db.todoList.removeAt(index);
    });
    db.updateDataBase();
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
            taskName: db.todoList[index][0],
            taskComplete: db.todoList[index][1],
            onChanged: (value) {
              checkBoxChanged(value, index);
            },
            onDelete: (context) {
              deleteTask(index);
            },
          );
        },
        itemCount: db.todoList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
