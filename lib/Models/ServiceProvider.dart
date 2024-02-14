import 'package:takeh_customer/Models/Category.dart';
import 'package:takeh_customer/Models/City.dart';
import 'package:takeh_customer/Models/Country.dart';

class ServiceProvider {
  int id = 0;
  String slug = '';
  Category category = Category();
  Country country = Country();
  City city = City();
  String id_front = '';
  String id_back = '';
  String driver_license_front = '';
  String driver_license_back = '';
  String car_license_front = '';
  String car_license_back = '';
  String status = '';
  String work_options = '';

  String car_type = '';
  String car_model = '';
  String car_year = '';
  String car_number = '';
  String car_color = '';

  ServiceProvider({
    this.id = 0,
    this.slug = '',
    // this.category = '',
    // this.country = '',
    // this.city = '',
    this.id_front = '',
    this.id_back = '',
    this.driver_license_front = '',
    this.driver_license_back = '',
    this.car_license_front = '',
    this.car_license_back = '',
    this.status = '',
    this.work_options = '',
    //
    this.car_type = '',
    this.car_model = '',
    this.car_year = '',
    this.car_number = '',
    this.car_color = '',
  });

  ServiceProvider.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.slug = data['slug'];
    } catch (e) {}
    try {
      this.category = Category.fromAPI(data['category']);
    } catch (e) {}
    try {
      this.country = Country.fromAPI(data['country']);
    } catch (e) {}
    try {
      this.city = City.fromAPI(data['city']);
    } catch (e) {}
    try {
      this.id_front = data['id_front'];
    } catch (e) {}
    try {
      this.id_back = data['id_back'];
    } catch (e) {}
    try {
      this.driver_license_front = data['driver_license_front'];
    } catch (e) {}
    try {
      this.driver_license_back = data['driver_license_back'];
    } catch (e) {}
    try {
      this.car_license_front = data['car_license_front'];
    } catch (e) {}
    try {
      this.car_license_back = data['car_license_back'];
    } catch (e) {}
    try {
      this.status = data['status'];
    } catch (e) {}
    try {
      this.work_options = data['work_options'];
    } catch (e) {}

    try {
      this.car_type = data['car_type'];
    } catch (e) {}
    try {
      this.car_model = data['car_model'];
    } catch (e) {}
    try {
      this.car_year = data['car_year'];
    } catch (e) {}
    try {
      this.car_number = data['car_number'];
    } catch (e) {}
    try {
      this.car_color = data['car_color'];
    } catch (e) {}
  }
}
