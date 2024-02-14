import 'package:takeh_customer/Models/ServiceProvider.dart';

class User {
  int id = 0;
  String name = '';
  String firstName = '';
  String lastName = '';
  String image = '';
  String phone = '';
  String status = '';
  String lastTimeUse = '';
  String activeUntil = '';
  String gender = '';
  String birthDay = '';
  String email = '';

  double wallet = 0.0;

  List<String> roles = [];
  List<String> permissions = [];
  double rate = 0.0;
  double points = 0.0;

  ServiceProvider sp = ServiceProvider();

  User({
    this.id = 0,
    this.name = '',
    this.firstName = '',
    this.lastName = '',
    this.image = '',
    this.phone = '',
    this.status = '',
    this.lastTimeUse = '',
    this.activeUntil = '',
    this.wallet = 0.0,
    this.rate = 0.0,
    this.points = 0.0,
    this.gender = '',
    this.birthDay = '',
    this.email = '',
  });

  User.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.firstName = data['first_name'];
    } catch (e) {}
    try {
      this.lastName = data['last_name'];
    } catch (e) {}
    try {
      this.name = '${this.firstName} ${this.lastName}';
    } catch (e) {}
    try {
      this.image = data['image'];
    } catch (e) {}
    try {
      this.phone = data['phone'];
    } catch (e) {}
    try {
      this.status = data['status'];
    } catch (e) {}
    try {
      this.lastTimeUse = data['last_time_use'];
    } catch (e) {}
    try {
      this.activeUntil = data['active_until'];
    } catch (e) {}

    try {
      this.rate = data['real_rating']['avg_reviews'] + 0.0;
    } catch (e) {}

    try {
      this.points = data['points'] + 0.0;
    } catch (e) {}

    try {
      this.wallet = data['wallet'] + 0.0;
    } catch (e) {}

    this.roles = [];
    try {
      if (data['roles'] != null) {
        for (var e in data['roles']) this.roles.add(e);
      }
    } catch (e) {}
    this.permissions = [];
    try {
      if (data['permissions'] != null) {
        for (var e in data['permissions']) this.permissions.add(e);
      }
    } catch (e) {}

    try {
      this.sp = ServiceProvider.fromAPI(data['service_provider']);
    } catch (e) {}
    try {
      this.gender = data['gender'];
    } catch (e) {}
    try {
      this.birthDay = data['birth_day'];
    } catch (e) {}
    try {
      this.email = data['email'];
    } catch (e) {}
  }
}
