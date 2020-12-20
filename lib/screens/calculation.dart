import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohabtask/model/country_models.dart';
import 'package:mohabtask/services/api.dart';
import 'package:mohabtask/widgets/resuable_edit_user.dart';
import 'package:provider/provider.dart';

class Calculation extends StatefulWidget {
  final String base;
  final CountryModel model;

  const Calculation({Key key, this.base, this.model}) : super(key: key);
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  TextEditingController txtController;
  String total = '1';
  @override
  void initState() {
    txtController = TextEditingController();
    total = widget.model.rate.toString();
    super.initState();
  }

  @override
  void dispose() {
    txtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final api = Provider.of<APiBase>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Convert'),
        backgroundColor: Colors.indigo,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("From", style: TextStyle(fontSize: 22)),
                Container(
                  width: 50,
                  height: 50,
                  child: _widget(code: widget.base, api: api),
                ),
                Text(widget.base, style: TextStyle(fontSize: 22)),
                ReusableEditUser(
                  controller: txtController,
                  hint: 'amount',
                  getText: (x) {
                    setState(() {
                      var amount = double.parse(x);
                      amount *= widget.model.rate;
                      total = amount.toStringAsFixed(3);
                      print(total);
                    });
                  },
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("To", style: TextStyle(fontSize: 22)),
                Container(
                  width: 50,
                  height: 50,
                  child: _widget(code: widget.model.code, api: api),
                ),
                Text(widget.model.code, style: TextStyle(fontSize: 22)),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    total,
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _widget({String code, APiBase api}) {
    return FutureBuilder<String>(
      future: api.flag(code),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return SvgPicture.network(
            data,
            placeholderBuilder: (BuildContext context) => Container(
                padding: const EdgeInsets.all(30.0),
                child: const CircularProgressIndicator()),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
