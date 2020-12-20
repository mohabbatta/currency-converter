import 'package:flutter/material.dart';
import 'package:mohabtask/my_home_page.dart';
import 'package:mohabtask/services/api.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<APiBase>(
      create: (context) => APi(),
      child: MaterialApp(
        title: 'Mohab\'s Task',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}
