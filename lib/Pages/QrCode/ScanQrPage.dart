import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:takeh_customer/Global/HomeAppBar.dart';
import 'package:takeh_customer/Provider/QrCodeProvider.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:takeh_customer/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ScanQrPage extends StatefulWidget {
  const ScanQrPage({super.key});
  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    qrCodeProvider.startScan = true;

    super.initState();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      qrCodeProvider.controller!.pauseCamera();
    } else if (Platform.isIOS) {
      qrCodeProvider.controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    qrCodeProvider.startScan = false;

    qrCodeProvider.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalSafeArea(
      horizontal: 0,
      vertical: 0,
      appBar: HomeAppBar(text: S.current.qrCode),
      body: Consumer<QrCodeProvider>(
        builder: (_, v, __) {
          return Stack(
            children: [
              if (v.startScan) ...[
                QRView(
                  key: qrKey,
                  onQRViewCreated: (p0) => v.onQRViewCreated(p0, context),
                ),
              ],
              //
              PositionedDirectional(
                top: MediaQuery.of(context).size.height * .15,
                start: 70,
                end: 70,
                child: Container(
                  decoration: BoxDecoration(color: AppColor.orange),
                  height: 2.5,
                ),
              ),
              PositionedDirectional(
                bottom: MediaQuery.of(context).size.height * .15,
                start: 70,
                end: 70,
                child: Container(
                  decoration: BoxDecoration(color: AppColor.orange),
                  height: 2.5,
                ),
              ),
              PositionedDirectional(
                top: MediaQuery.of(context).size.height * .2,
                bottom: MediaQuery.of(context).size.height * .2,
                end: 50,
                child: Container(
                  decoration: BoxDecoration(color: AppColor.orange),
                  width: 2.5,
                ),
              ),
              PositionedDirectional(
                top: MediaQuery.of(context).size.height * .2,
                bottom: MediaQuery.of(context).size.height * .2,
                start: 50,
                child: Container(
                  decoration: BoxDecoration(color: AppColor.orange),
                  width: 2.5,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
