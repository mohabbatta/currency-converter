import 'package:flutter/material.dart';
import 'package:mohabtask/bloc/rate_page_bloc.dart';
import 'package:mohabtask/model/rate_page_model.dart';
import 'package:mohabtask/screens/calculation.dart';
import 'package:mohabtask/services/api.dart';
import 'package:mohabtask/widgets/custom_drob_down.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Rate extends StatefulWidget {
  final RatePageBloc bloc;
  const Rate({Key key, this.bloc}) : super(key: key);

  static Widget create(BuildContext context) {
    final api = Provider.of<APiBase>(context, listen: false);
    return Provider<RatePageBloc>(
      create: (_) => RatePageBloc(api: api),
      child: Consumer<RatePageBloc>(
          builder: (context, bloc, _) => Rate(bloc: bloc)),
      dispose: (context, bloc) => bloc.dispose(),
    );
  }

  @override
  _RateState createState() => _RateState();
}

class _RateState extends State<Rate> {
  @override
  void initState() {
    widget.bloc.getData();
    super.initState();
  }

  void _getValue(String x) {
    widget.bloc.changeBase(x, context);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RatePageModel>(
        stream: widget.bloc.modelStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                child: Column(
                  children: [
                    CustomDropDown(
                      nameText: "base",
                      value: data.base,
                      getValue: _getValue,
                      arrItems: data.rates.map((e) => e.code).toList(),
                    ),
                    Expanded(
                      child: ListView.separated(
                          separatorBuilder: (context, index) => SizedBox(
                                height: 8,
                                child: Container(color: Colors.black12),
                              ),
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.all(4),
                          shrinkWrap: true,
                          itemCount: data.rates.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Calculation(
                                              base: data.base,
                                              model: data.rates[index],
                                            )));
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child: _widget(data.rates[index].code),
                                      ),
                                      Text(
                                        data.rates[index].code,
                                        style: TextStyle(fontSize: 30),
                                      ),
                                      Text(
                                        data.rates[index].rate
                                            .toStringAsFixed(3),
                                        style: TextStyle(fontSize: 30),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _widget(String code) {
    return FutureBuilder<String>(
      future: widget.bloc.getCountry(code),
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
