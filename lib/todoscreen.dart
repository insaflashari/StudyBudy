import 'package:flutter/material.dart';
import 'package:studybuddy/todolist.dart';
import 'package:studybuddy/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _controller = TextEditingController();
  List<Map<String, dynamic>> toDoList = [];

  @override
  void initState() {
    super.initState();
    loadTasks(); // load saved tasks when app starts
  }

  // Save tasks to SharedPreferences
  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('todo_list', jsonEncode(toDoList));
  }

  // Load tasks from SharedPreferences
  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    String? encoded = prefs.getString('todo_list');
    if (encoded != null) {
      List<dynamic> decoded = jsonDecode(encoded);
      setState(() {
        toDoList = decoded.cast<Map<String, dynamic>>();
      });
    } else {
      // First launch: show default example task
      setState(() {
        toDoList = [
          {'name': 'To-do #1 (swipe left to delete)', 'completed': false},
        ];
      });
      await saveTasks(); // save default task for next launches
    }
  }

  void checkBoxChanged(int index) async {
    setState(() {
      toDoList[index]['completed'] = !(toDoList[index]['completed'] as bool);
    });
    await saveTasks();
  }

  void saveNewTask() async {
    if (_controller.text.isEmpty) return;
    setState(() {
      toDoList.add({'name': _controller.text, 'completed': false});
      _controller.clear();
    });
    await saveTasks();
  }

  void deleteTask(int index) async {
    setState(() {
      toDoList.removeAt(index);
    });
    await saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      appBar: AppBar(
        title: Text(
          "TO-DO LIST",
          style: textStyle(25, Colors.white, FontWeight.w700),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (BuildContext context, int index) {
          return TodoList(
            taskName: toDoList[index]['name'] as String,
            taskCompleted: toDoList[index]['completed'] as bool,
            onChanged: (value) => checkBoxChanged(index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Add a new to-do item',
                    hintStyle: TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.blue.shade300,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue.shade400),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: saveNewTask,
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
