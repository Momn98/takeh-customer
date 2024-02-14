import 'package:takeh_customer/Models/Country.dart';
import 'package:takeh_customer/Models/City.dart';

Future<List<Address>> loopAddresss(List data) async {
  List<Address> _arr = [];
  for (var item in data) _arr.add(Address.fromAPI(item));
  return _arr;
}

class Address {
  int id = 0;
  String nick_name = '';
  String location = '';
  double latitude = 0.0;
  double longitude = 0.0;
  Country country = Country();
  City city = City();
  String apartment = '';
  String street = '';
  String area = '';
  String note = '';

  Address({
    this.id = 0,
    this.nick_name = '',
    this.location = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
    // this.country = '',
    // this.city = '',
    this.apartment = '',
    this.street = '',
    this.area = '',
    this.note = '',
  });

  Address.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.nick_name = data['nick_name'];
    } catch (e) {}
    try {
      this.location = data['location'];
    } catch (e) {}
    try {
      this.latitude = data['latitude'];
    } catch (e) {}
    try {
      this.longitude = data['longitude'];
    } catch (e) {}
    try {
      this.country = Country.fromAPI(data['country']);
    } catch (e) {}
    try {
      this.city = City.fromAPI(data['city']);
    } catch (e) {}
    try {
      this.apartment = data['apartment'];
    } catch (e) {}
    try {
      this.street = data['street'];
    } catch (e) {}
    try {
      this.area = data['area'];
    } catch (e) {}
    try {
      this.note = data['note'];
    } catch (e) {}
  }
}
