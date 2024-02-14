import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class QrCodeProvider extends ChangeNotifier {
  bool _startScan = false;
  bool get startScan => _startScan;
  set startScan(bool startScan) {
    _startScan = startScan;
  }

  setScan() {
    _startScan = !_startScan;
    notifyListeners();
  }

  Barcode? result;
  QRViewController? controller;

  void onQRViewCreated(QRViewController controller, BuildContext context) {
    this.controller = controller;
    controller.resumeCamera();

    controller.scannedDataStream.listen((scanData) {
      result = scanData;

      notifyListeners();

      this.startScan = false;

      getTheOrder(context);
    });
  }

  getTheOrder(BuildContext context) async {
    if (result != null) {
      Map data = jsonDecode(result!.code.toString());

      if (data['the_id'] == 0) return;

      // loadingDialog(context);
      // orderProvider.order.id = data['the_id'];
      // await orderProvider.getOrderInfo();
      // NavMove.closeDialog(context);
      // // this.startScan = true;
      // NavMove.goBack(context);
      // if (orderProvider.order.id > 0) {
      //   orderProvider.fromQrCode = true;
      //   NavMove.goToPage(context, OneOrderPage());
      // }
    }

    this.startScan = true;
  }
}
