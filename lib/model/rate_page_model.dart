import 'package:mohabtask/model/country_models.dart';

class RatePageModel {
  final String base;
  final List<CountryModel> rates;

  RatePageModel({this.rates = const [], this.base = 'EUR'});

  RatePageModel copyWith({String base, List<CountryModel> rates}) {
    return RatePageModel(base: base ?? this.base, rates: rates ?? this.rates);
  }

  factory RatePageModel.fromMap(Map<dynamic, dynamic> value) {
    Map<String, dynamic> d = value['rates'];
    List<CountryModel> modelData = d.entries
        .map((entry) =>
            CountryModel(code: entry.key, rate: entry.value, flag: entry.key))
        .toList();
    return RatePageModel(base: value['base'], rates: modelData);
  }

  Map<dynamic, dynamic> toMap() {
    return <String, dynamic>{
      'base': base,
      'rates': rates,
    };
  }
}
