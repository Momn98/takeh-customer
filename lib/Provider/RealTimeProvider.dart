import 'package:shared_preferences/shared_preferences.dart';
import 'package:takeh_customer/Shared/SharedManaged.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:flutter/material.dart';

class RealTimeProvider extends ChangeNotifier {
  late SharedPreferences _pre;
  late String _token = '';

  late PusherClient pusher;
  late PusherOptions _options;

  // RealTimeProvider() {
  //   // connect();
  // }

  String connectStatus = '';

  Future connect() async {
    if (_token == '') {
      _pre = await SharedPreferences.getInstance();
      _token = _pre.getString(SharedKeys.token) ?? '';
    }

    // printLog('_token $_token _token');

    _options = PusherOptions(
      host: 'app.takeh.online',
      wsPort: 6001,
      wssPort: 6001,
      encrypted: true,
      auth: PusherAuth(
        'https://app.takeh.online/broadcasting/auth',
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    pusher = PusherClient(
      'nmlg5g4tw123123',
      _options,
      autoConnect: true,
      enableLogging: true,
    );

    pusher.connect();

    pusher.onConnectionError((error) {
      // printLog("error: ${error?.message}");
    });

    pusher.onConnectionStateChange((state) {
      connectStatus = state!.currentState!;
      // printLog("currentState: ${state.currentState} -- -- ");

      notifyListeners();
    });

    return;
  }
}
