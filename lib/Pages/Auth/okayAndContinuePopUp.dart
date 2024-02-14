import 'package:takeh_customer/Provider/SignProvider.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:takeh_customer/Shared/i18n.dart';

okayAndContinuePopUp(BuildContext context) async {
  return await showModalBottomSheet(
    isScrollControlled: true,
    enableDrag: false,
    isDismissible: false,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    builder: (BuildContext context) {
      return OkayAndContinueWidget();
    },
  );
}

class OkayAndContinueWidget extends StatelessWidget {
  const OkayAndContinueWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Consumer<SignProvider>(
        builder: (_, v, __) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.50,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                setHeightSpace(10),
                Stack(
                  children: [
                    Center(
                      child: globalText(
                        S.current.chickPhoneNumber,
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    //
                    PositionedDirectional(
                      end: 0,
                      child: InkWell(
                        onTap: () => NavMove.closeDialog(context),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
                Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        setHeightSpace(20),
                        globalText(
                          S.current.weWillChickThisPhoneNumber,
                          style: TextStyle(fontSize: 18),
                        ),
                        setHeightSpace(10),
                        globalText(
                          S.current.isPhoneNumberCorrectOrWantToChangeIt,
                          style: TextStyle(fontSize: 18),
                        ),
                        setHeightSpace(20),
                        Center(
                          child: globalText(
                            v.number.phoneNumber.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),

                        // setHeightSpace(20),
                        // globalText(
                        //   'Pick Up location',
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.bold,
                        //     fontSize: 18,
                        //   ),
                        // ),
                        // textFiled(TextEditingController(),
                        //     text: 'Referance ID'),
                        // setHeightSpace(10),
                      ],
                    ),
                  ),
                ),
                setHeightSpace(20),
                //
                Container(
                  width: double.infinity,
                  child: globalButton(
                    S.current.trueContinue,
                    () => NavMove.goBack(context, data: {'continue': true}),
                    fontWeight: FontWeight.normal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    backColor: Colors.black,
                    borderColor: Colors.black,
                    textColor: Colors.white,
                  ),
                ),
                //
                setHeightSpace(25),
              ],
            ),
          );
        },
      ),
    );
  }
}
