import 'package:flutter/material.dart';

class ReusableEditUser extends StatelessWidget {
  ReusableEditUser({this.controller, this.getText, this.hint});

  final TextEditingController controller;
  final String hint;
  final Function getText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                style: TextStyle(
                  fontSize: 22,
                ),
                controller: controller,
                decoration: InputDecoration(
                    hintText: hint, hintStyle: TextStyle(color: Colors.indigo)),
                onChanged: getText,
              ),
            ),
          )
        ],
      ),
    );
  }
}
