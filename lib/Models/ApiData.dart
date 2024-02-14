import 'package:http/http.dart';
import 'dart:convert';

class ApiData {
  int statusCode = 200;
  String message = '';
  bool showMessage = false;
  var data;
  int nextPage = 1;
  bool haveMoreData = true;

  ApiData({
    this.statusCode = 200,
    this.message = '',
    this.showMessage = false,
    // this.data,
    this.nextPage = 1,
    this.haveMoreData = true,
  });

  ApiData.fromAPI(Response data) {
    // if (data.statusCode != 200) return;
    this.statusCode = data.statusCode;

    Map body = jsonDecode(data.body);

    try {
      this.message = body['message'];
    } catch (e) {}

    try {
      this.showMessage = body['show_message'] ?? false;
    } catch (e) {}

    try {
      this.data = body['data'];
    } catch (e) {}

    try {
      this.nextPage = body['next_page'] ?? 0;
    } catch (e) {}

    try {
      this.haveMoreData = body['have_more'] ?? false;
    } catch (e) {}
  }
}
