import 'package:takeh_customer/Models/City.dart';

Future<List<Country>> loopCountrys(List data) async {
  List<Country> _arr = [];
  for (var item in data) _arr.add(Country.fromAPI(item));
  return _arr;
}

class Country {
  int id = 0;
  String flag = '';
  String name = '';
  String currency = '';
  String symbol = '';
  double currency_rate = 0.0;
  List<City> citys = [];

  Country({
    this.id = 0,
    this.flag = '',
    this.name = '',
    this.currency = '',
    this.symbol = '',
    this.currency_rate = 0.0,
    // this.citys = '',
  });

  Country.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.flag = data['flag'];
    } catch (e) {}
    try {
      this.name = data['name'];
    } catch (e) {}
    try {
      this.currency = data['currency'];
    } catch (e) {}
    try {
      this.symbol = data['symbol'];
    } catch (e) {}
    try {
      this.currency_rate = data['currency_rate'];
    } catch (e) {}

    this.citys = [];
    try {
      if (data['citys'] != null)
        for (var el in data['citys']) this.citys.add(el);
    } catch (e) {}
  }
}
