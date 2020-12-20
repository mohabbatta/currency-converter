import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:mohabtask/model/rate_page_model.dart';
import 'package:mohabtask/services/api_path.dart';

abstract class APiBase {
  Future<RatePageModel> getData();
  Future<RatePageModel> changeBase(String code);
  Future<String> flag(String code);
}

class APi implements APiBase {
  String key = '5d1dca551ad486041299c52cbeb2ea2e';

  @override
  Future<RatePageModel> getData() async {
    http.Response response = await http.get(ApiPath.latest(key));
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      return RatePageModel.fromMap(data);
    } else {
      return RatePageModel(rates: [], base: 'EUR');
    }
  }

  @override
  Future<String> flag(String code) async {
    http.Response response = await http.get(ApiPath.flag(code));
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      String flag = data[0]['flag'];
      return flag;
    } else {
      return null;
    }
  }

  @override
  Future<RatePageModel> changeBase(String code) async {
    http.Response response = await http.get(ApiPath.changeBase(key, code));
    if (response.statusCode == 200) {
      dynamic data = json.decode(response.body);
      if (!data['success']) {
        return throw PlatformException(
            code: 'function_access_restricted',
            message: 'Access Restricted - Your current Subscription Plan does'
                ' not support this API Function');
      } else {
        return RatePageModel.fromMap(data);
      }
    } else {
      return throw PlatformException(
          code: 'function_access_restricted',
          message: 'Access Restricted - Your current Subscription Plan'
              ' does not support this API Function');
    }
  }
}
