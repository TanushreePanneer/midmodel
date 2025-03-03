
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: AuthScreen()));

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _islogin = true;
  void _toggleMode() => setState(() {
    _islogin = !_islogin;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_islogin ? 'Login' : 'Signup')),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(decoration: InputDecoration(labelText: 'Email')),
              TextField(decoration: InputDecoration(labelText: 'Password'),obscureText: true),
              SizedBox(height: 10),
              ElevatedButton(onPressed: () {}, child: Text(_islogin ? 'Login' : 'Signup')),
              TextButton(onPressed: _toggleMode, child: Text(_islogin ? 'Create Account' : 'Back to Login')),
    ],
    ),
    ),
    );
  }
}
