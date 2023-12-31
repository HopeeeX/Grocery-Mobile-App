import 'package:flutter/material.dart';
import 'package:flutter_internals/grocery_app.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: const GroceryApp()
    );
  }
}
