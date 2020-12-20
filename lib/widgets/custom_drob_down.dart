import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  final String nameText;
  final String value;
  final List<String> arrItems;
  final Function getValue;
  const CustomDropDown(
      {Key key, this.nameText, this.value, this.arrItems, this.getValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          nameText,
          style: TextStyle(
            fontSize: 22,
            fontFamily: 'VarelaRound',
          ),
        ),
        SizedBox(width: 20),
        DropdownButton<String>(
          value: value,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(
              fontSize: 24, fontFamily: 'VarelaRound', color: Colors.black),
          underline: Container(
            height: 2,
            color: Colors.indigo,
          ),
          onChanged: getValue,
          items: arrItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )
      ],
    );
  }
}
