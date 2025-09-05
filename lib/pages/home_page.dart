import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:planizi/data/database.dart';
import 'package:planizi/util/dialog_box.dart';
import 'package:planizi/util/todo_tile.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  // text controller
  final _controller = TextEditingController();

  ToDoDataBase db= ToDoDataBase();

  @override
  void initState() {
    // if this is the 1st time ever openin the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
    super.initState();
  }
  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState( () {
      db.toDoList [index] [1] = !db.toDoList [index] [1];
    });
    db.updateDataBase();
  }
  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDataBase();
  }

  // create a new task
  void createNewTask( ) {
    showDialog(
    context: context,
    builder: (context) {
      return DialogBox(
        controller: _controller,
          onSave: saveNewTask,

          onCancel: ()=> Navigator.of(context).pop( ),

      );
    },
    );
  }
  // delete task
  void deleteTask(int index) {
    setState( () {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text("To Do",style: TextStyle(fontWeight:FontWeight.bold),),
        centerTitle: true,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
          onPressed: createNewTask,
        child:Icon(Icons.add),
      ),


      body: Stack(
        children: [
      // Watermark text
       Center(
        child: Opacity(
        opacity: 0.08, // transparency
          child: Text(
          "codew_Hmzii",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        ),
       ),


      ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      ],
      ),
    );
  }
}
