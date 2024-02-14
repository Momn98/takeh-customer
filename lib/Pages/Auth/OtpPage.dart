import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:takeh_customer/Global/loadingDialog.dart';
import 'package:takeh_customer/Provider/AuthProvider.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:takeh_customer/main.dart';

class OtpPageView extends StatefulWidget {
  final Map data;
  final bool haveAccount;

  OtpPageView({Key? key, required this.data, required this.haveAccount})
      : super(key: key);

  @override
  _OtpPageViewState createState() => _OtpPageViewState();
}

class _OtpPageViewState extends State<OtpPageView> {
  TextEditingController _otpController = TextEditingController();
  String text = '';
  String _phoneNumber = '';
  String signature = "";

  @override
  void initState() {
    super.initState();

    _phoneNumber = widget.data['phone'];

    sendOtpWithSignature();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();

    super.dispose();
  }

  Future<void> sendOtpWithSignature() async {
    await SmsAutoFill().listenForCode();

    try {
      signature = await SmsAutoFill().getAppSignature;

      authProvider.sendOtpCode(context, _phoneNumber, signature,
          withLoading: false);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, v, __) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              if (v.codeSend) ...[
                if (v.timeDown == 0) ...[
                  TextButton(
                    child: Text(
                      S.current.resendCode,
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      v.sendOtpCode(context, _phoneNumber, signature);
                    },
                  ),
                ] else ...[
                  TextButton(
                    child: Text(
                      S.current.resendCode + " ${v.timeDown}",
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () {},
                  ),
                ],
              ],
            ],
          ),
          body: Column(
            children: [
              setHeightSpace(30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    globalText(
                      S.current.otpVerification,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    setHeightSpace(10),
                    globalText(S.current.codeHasBeenSentTo),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: globalText(_phoneNumber),
                    ),
                  ],
                ),
              ),
              setHeightSpace(55),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: PinFieldAutoFill(
                  decoration: UnderlineDecoration(
                    textStyle: TextStyle(color: Colors.black),
                    colorBuilder: FixedColorBuilder(Colors.black),
                  ),
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  currentCode: _otpController.text,
                  onCodeSubmitted: (code) {},
                  onCodeChanged: (code) {
                    if (code != null && code.length == 6) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      _checkOtpCode();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _checkOtpCode() async {
    bool res = await authProvider.checkOtpCode(
      context,
      _phoneNumber,
      _otpController.text,
    );

    if (res) {
      loadingDialog(context);
      if (widget.haveAccount) {
        await authProvider.logIn(
          context,
          widget.data,
          widget.haveAccount,
        );
      } else {
        await authProvider.signUp(
          context,
          widget.data,
          false,
        );
      }
    }
  }
}
