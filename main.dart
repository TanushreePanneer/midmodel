import 'package:flutter/material.dart';


void main() => runApp(MaterialApp(home: TodoApp()));


class TodoApp extends StatefulWidget {
 @override
 _TodoAppState createState() => _TodoAppState();
}


class _TodoAppState extends State<TodoApp> {
 List<String> todos = [];
 TextEditingController controller = TextEditingController();


 void addTodo() {
   if (controller.text.isNotEmpty) {
     setState(() => todos.add(controller.text));
     controller.clear();
   }
 }


 void deleteTodo(int index) {
   setState(() => todos.removeAt(index));
 }


 void editTodo(int index) {
   controller.text = todos[index];
   showDialog(
     context: context,
     builder: (_) => AlertDialog(
       title: Text('Edit Todo'),
       content: TextField(controller: controller),
       actions: [
         TextButton(
           onPressed: () {
             setState(() => todos[index] = controller.text);
             controller.clear();
             Navigator.pop(context);
           },
           child: Text('Update'),
         )
       ],
     ),
   );
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
           child: ListView.builder(
             itemCount: todos.length,
             itemBuilder: (_, i) => ListTile(
               title: Text(todos[i]),
               trailing: Row(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   IconButton(icon: Icon(Icons.edit), onPressed: () => editTodo(i)),
                   IconButton(icon: Icon(Icons.delete), onPressed: () => deleteTodo(i)),
                 ],
               ),
             ),
           ),
         )
       ],
     ),
   );
 }
}
