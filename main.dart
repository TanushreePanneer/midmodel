
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: TodoApp()));

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<String> todos = [];
  TextEditingController controller = TextEditingController();

  void addTodo(){
    if (controller.text.isNotEmpty){
      setState(() {
        todos.add(controller.text);
        controller.clear();
      });
    }
  }

  void deleteTodo(int index){
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo List')),
      body: Column(
        children: [
          TextField(controller: controller, decoration: InputDecoration(hintText: 'Enter Todo')),
          ElevatedButton(onPressed: addTodo, child: Text('Add')),
          Expanded(
            child: ListView(
              children: List.generate(todos.length, (i) => ListTile(
                title: Text(todos[i]),
                trailing: Wrap(
                  children: [
                    IconButton(icon: Icon(Icons.delete), onPressed: () => deleteTodo(i)),
                  ],
                ),
              )),
            ),
          )
        ],
      ),
    );
  }
}