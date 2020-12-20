import 'package:flutter/material.dart';
import 'package:mohabtask/screens/rate.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: Text(
          "Currency Rate",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Rate.create(context),
    );
  }
}
