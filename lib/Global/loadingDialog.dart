import 'package:flutter/material.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/i18n.dart';

loadingDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      // return object of type Dialog
      return PopScope(
        canPop: false,
        child: Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            constraints: BoxConstraints(maxHeight: 200),
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            // child: LoaderPlace(text: '${S.current.pleaseWait} ..', top: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                setHeightSpace(20),
                globalText('${S.current.pleaseWait} ..'),
              ],
            ),
          ),
        ),
      );
    },
  );
}
