import 'package:takeh_customer/Models/Address.dart';
import 'package:takeh_customer/Models/OrderStatus.dart';
import 'package:takeh_customer/Models/Category.dart';
import 'package:takeh_customer/Models/Answer.dart';
import 'package:takeh_customer/Models/PromoCode.dart';
import 'package:takeh_customer/Models/User.dart';

Future<List<Order>> loopOrders(List data) async {
  List<Order> _arr = [];
  for (var item in data) _arr.add(Order.fromAPI(item));
  return _arr;
}

class Order {
  int id = 0;
  String slug = '';
  User user = User();
  Category category = Category();
  User service_provider = User();
  String time = '';
  Address from_address = Address();
  Address to_address = Address();
  double price = 0.0;
  double point = 0.0;
  int employee_count = 0;
  OrderStatus status = OrderStatus();
  PromoCode promoCode = PromoCode();
  String start_time = '';
  String end_time = '';
  double user_rate = 0.0;
  double service_provider_rate = 0.0;
  //

  List<Answer> answers = [];

  String created_date = '';
  String created_time = '';
  String created_at = '';
  String created_ago = '';

  double distance = 0.0;
  double duration = 0.0;

  String order_time = '';

  double remain_balance = 0.0;
  double discounted_amount = 0.0;
  double paid_cash = 0.0;
  double paid_wallet = 0.0;

  Order({
    this.id = 0,
    this.slug = '',
    this.time = '',
    this.price = 0.0,
    this.point = 0.0,
    this.employee_count = 0,
    this.start_time = '',
    this.end_time = '',
    this.user_rate = 0.0,
    this.service_provider_rate = 0.0,
    // this.answers = [],

    this.created_date = '',
    this.created_time = '',
    this.created_at = '',
    this.created_ago = '',
    //
    this.distance = 0.0,
    this.duration = 0.0,
    //
    this.remain_balance = 0.0,
    this.discounted_amount = 0.0,
    this.paid_cash = 0.0,
    this.paid_wallet = 0.0,
  });

  Order.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.slug = data['slug'];
    } catch (e) {}
    try {
      this.user = User.fromAPI(data['user']);
    } catch (e) {}
    try {
      this.category = Category.fromAPI(data['category']);
    } catch (e) {}
    try {
      this.service_provider = User.fromAPI(data['service_provider']);
    } catch (e) {}
    try {
      this.time = data['time'];
    } catch (e) {}
    try {
      this.from_address = Address.fromAPI(data['from_address']);
    } catch (e) {}
    try {
      this.to_address = Address.fromAPI(data['to_address']);
    } catch (e) {}
    try {
      this.price = data['price'] + 0.0;
    } catch (e) {}
    try {
      this.point = data['point'] + 0.0;
    } catch (e) {}
    try {
      this.employee_count = data['employee_count'] + 0;
    } catch (e) {}
    try {
      this.status = OrderStatus.fromAPI(data['status']);
    } catch (e) {}
    try {
      this.promoCode = PromoCode.fromAPI(data['promo_code']);
    } catch (e) {}
    try {
      this.start_time = data['start_time'];
    } catch (e) {}
    try {
      this.end_time = data['end_time'];
    } catch (e) {}
    try {
      this.user_rate = data['user_rate'] + 0.0;
    } catch (e) {}
    try {
      this.service_provider_rate = data['service_provider_rate'] + 0.0;
    } catch (e) {}

    this.answers = [];
    try {
      if (data['answers'] != null)
        for (var element in data['answers'])
          this.answers.add(Answer.fromAPI(element));
    } catch (e) {}

    for (var ans in this.answers) {
      if (ans.type == 'date-time') {
        this.order_time = ans.answer;
      }
    }

    try {
      this.created_date = data['created_date'];
    } catch (e) {}
    try {
      this.created_time = data['created_time'];
    } catch (e) {}
    try {
      this.created_at = data['created_at'];
    } catch (e) {}
    try {
      this.created_ago = data['created_ago'];
    } catch (e) {}

    try {
      this.distance = data['distance'] + 0.0;
    } catch (e) {}
    try {
      this.duration = data['duration'] + 0.0;
    } catch (e) {}

    try {
      this.remain_balance = data['remain_balance'] + 0.0;
    } catch (e) {}

    try {
      this.discounted_amount = data['discounted_amount'] + 0.0;
    } catch (e) {}

    try {
      this.paid_cash = data['paid_cash'] + 0.0;
    } catch (e) {}

    try {
      this.paid_wallet = data['paid_wallet'] + 0.0;
    } catch (e) {}
  }
}
