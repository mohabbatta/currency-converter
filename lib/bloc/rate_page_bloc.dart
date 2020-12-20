import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mohabtask/model/country_models.dart';
import 'package:mohabtask/model/rate_page_model.dart';
import 'package:mohabtask/services/api.dart';

class RatePageBloc {
  final APiBase api;
  RatePageBloc({this.api});

  final StreamController<RatePageModel> _modelController =
      StreamController<RatePageModel>();
  Stream<RatePageModel> get modelStream => _modelController.stream;
  RatePageModel _model = RatePageModel();

  void dispose() {
    _modelController.close();
  }

  void updateWith({String base, List<CountryModel> modelData}) {
    _model = _model.copyWith(base: base, rates: modelData);
    _modelController.add(_model);
  }

  Future<void> getData() async {
    RatePageModel data = await api.getData();
    updateWith(base: data.base, modelData: data.rates);
  }

  Future<String> getCountry(String code) async {
    String result = await api.flag(code);
    return result;
  }

  Future<void> changeBase(String code, BuildContext context) async {
    try {
      RatePageModel model = await api.changeBase(code);
      updateWith(base: model.base, modelData: model.rates);
    } on PlatformException catch (e) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(e.code),
              content: Text(e.message),
            );
          });
    }
  }
}
