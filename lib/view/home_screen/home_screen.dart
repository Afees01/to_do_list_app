import 'package:flutter/material.dart';
import 'package:to_do_list_app/controller/home_screen_controller.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> Tasks = [];

  void _addTask(String title) {
    setState(() {
      HomeScreenController.addData(tittle: title.toString(), completed: false);
    });
  }

  void _deleteTask(int index) {
    setState(() {
      Tasks.removeAt(index);
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      Tasks[index]['completed'] = !Tasks[index]['completed'];
    });
  }

  void _showAddTaskDialog() {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Task'),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Enter task title'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                _addTask(_controller.text);
                Navigator.of(context).pop();
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: Tasks.length,
        itemBuilder: (context, index) {
          final task = Tasks[index];
          return GestureDetector(
            onLongPress: () => _deleteTask(index),
            child: ListTile(
              leading: Checkbox(
                value: task['completed'],
                onChanged: (value) => _toggleTaskCompletion(index),
              ),
              title: Text(
                task['title'],
                style: TextStyle(
                  decoration: task['completed']
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
