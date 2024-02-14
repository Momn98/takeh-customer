import 'package:takeh_customer/Provider/TabBarProvider.dart';
import 'package:takeh_customer/Provider/OrderProvider.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:takeh_customer/Global/input.dart';
import 'package:takeh_customer/Shared/i18n.dart';
// import 'package:takeh_customer/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

addAddressPopUp(BuildContext context) async {
  // orderProvider.nick_name.text = '';
  // orderProvider.street.text = '';
  // orderProvider.apartment.text = '';
  // orderProvider.area_text.text = '';
  // orderProvider.note.text = '';

  return await showModalBottomSheet(
    isScrollControlled: true,
    enableDrag: false,
    isDismissible: false,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (BuildContext context) {
      return PopScope(
        canPop: false,
        child: Consumer2<TabBarProvider, OrderProvider>(
          builder: (_, v, v2, __) {
            return Container(
              height: MediaQuery.of(context).size.height * .60,
              padding: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: v2.locationFormKey,
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
                            S.current.enterLocationInfo,
                            style: TextStyle(
                              // color: AppColor.orange,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
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
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            textFiled(
                              v2.nick_name,
                              label: S.current.nick_name,
                              valdator: (value) {
                                if (value == null || value == '')
                                  return S.current.thisFieldIsRequired;
                                return null;
                              },
                            ),
                            setHeightSpace(10),
                            textFiled(
                              v2.area_text,
                              label: S.current.area,
                            ),
                            setHeightSpace(10),
                            textFiled(
                              v2.street,
                              label: S.current.street,
                            ),
                            setHeightSpace(10),
                            textFiled(
                              v2.apartment,
                              label: S.current.apartment,
                            ),
                            setHeightSpace(10),
                            textFiled(
                              v2.note,
                              label: S.current.note,
                            ),
                          ],
                        ),
                      ),
                    ),
                    setHeightSpace(10),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: globalButton(
                            S.current.addLocation,
                            () {
                              if (!v2.locationFormKey.currentState!.validate())
                                return;

                              NavMove.goBack(context, data: {
                                'add': true,
                                'nick_name': v2.nick_name.text,
                                'street': v2.street.text,
                                'apartment': v2.apartment.text,
                                'area_text': v2.area_text.text,
                                'note': v2.note.text,
                              });
                            },
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    setHeightSpace(15),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
