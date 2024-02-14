import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:takeh_customer/Pages/Stander-Pages/PoliciesPage.dart';
import 'package:takeh_customer/Global/selectImagePopUp.dart';
import 'package:takeh_customer/Provider/TabBarProvider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:takeh_customer/Global/input.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:io';

Future chooseYesNoDialog(
  BuildContext context,
  String text, {
  String? extraText,
  TextStyle? extraStyle,
  bool showMoreInfo = false,
  String? yesText,
  Color? yesColor,
  bool showYes = true,
  String? noText,
  Color? noColor,
  bool showNo = true,
  bool withInput = false,
  int inputMinLine = 1,
  String textInput = '',
  String textPlaceInput = '',
  bool withNumber = false,
  String numberInput = '',
  String numberPlaceInput = '',
  bool withRate = false,
  String textRate = '',
  bool withImages = false,
  int minImageCount = 0,
  bool withDate = false,
  String dateText = '',
  String? Function(String?)? validator,
  String? Function(String?)? numberValidator,
  List<Widget>? widgets,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return ChooseYesNoDialog(
        text,
        extraText: extraText,
        extraStyle: extraStyle,
        showMoreInfo: showMoreInfo,
        yesText: yesText,
        yesColor: yesColor,
        noText: noText,
        noColor: noColor,
        withInput: withInput,
        inputMinLine: inputMinLine,
        textInput: textInput,
        textPlaceInput: textPlaceInput,
        withNumber: withNumber,
        numberInput: numberInput,
        numberPlaceInput: numberPlaceInput,
        withRate: withRate,
        textRate: textRate,
        withImages: withImages,
        minImageCount: minImageCount,
        validator: validator,
        numberValidator: numberValidator,
        withDate: withDate,
        dateText: dateText,
        showYes: showYes,
        showNo: showNo,
        widgets: widgets,
      );
    },
  );
}

// ignore: must_be_immutable
class ChooseYesNoDialog extends StatelessWidget {
  final String text;
  final String? extraText;
  final TextStyle? extraStyle;
  final bool showMoreInfo;
  final String? yesText;
  final Color? yesColor;
  final String? noText;
  final Color? noColor;
  final bool withInput;
  final int inputMinLine;
  final String? textInput;
  final String? textPlaceInput;
  final bool withNumber;
  final String? numberInput;
  final String? numberPlaceInput;
  final bool withRate;
  final String? textRate;
  final bool withImages;
  final int minImageCount;
  final bool withDate;
  final String? dateText;
  final bool showYes;
  final bool showNo;
  final String? Function(String?)? validator;
  final String? Function(String?)? numberValidator;
  final List<Widget>? widgets;

  ChooseYesNoDialog(
    this.text, {
    this.extraText,
    this.extraStyle,
    this.showMoreInfo = false,
    this.yesText,
    this.yesColor,
    this.noText,
    this.noColor,
    this.withInput = false,
    this.inputMinLine = 1,
    this.textInput,
    this.textPlaceInput,
    this.withNumber = false,
    this.numberInput,
    this.numberPlaceInput,
    this.withRate = false,
    this.textRate,
    this.withImages = false,
    this.minImageCount = 0,
    this.withDate = false,
    this.dateText,
    this.validator,
    this.numberValidator,
    this.showYes = true,
    this.showNo = true,
    this.widgets,
  });

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController input = TextEditingController();
  TextEditingController number = TextEditingController();
  double rate = 0;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Consumer<TabBarProvider>(
        builder: (_, v, __) {
          return Dialog(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
              child: Form(
                key: formKey,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      globalText(
                        text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Divider(color: AppColor.orange),
                      setHeightSpace(10),
                      if (extraText != null) ...[
                        globalText(
                          extraText!,
                          style: extraStyle ?? TextStyle(),
                        ),
                        setHeightSpace(10),
                      ],
                      if (showMoreInfo) ...[
                        InkWell(
                          onTap: () => NavMove.goToPage(
                              context, PoliciesPage(page: 'about-app')),
                          child: globalText(
                            S.current.moreInfoAboutApp,
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        setHeightSpace(10),
                      ],
                      if (withRate) ...[
                        RatingBar.builder(
                          initialRating: rate,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemSize: 30,
                          onRatingUpdate: (rating) => rate = rating,
                          itemBuilder: (context, _) =>
                              Icon(Icons.star, color: Colors.amber),
                        ),
                        setHeightSpace(10),
                      ],
                      if (withNumber) ...[
                        globalText(
                          numberInput!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (numberInput != null) setHeightSpace(20),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: textFiled(
                            number,
                            label: numberPlaceInput,
                            valdator: numberValidator,
                            max: null,
                            withBorder: false,
                            type: TextInputType.number,
                          ),
                        ),
                        setHeightSpace(10),
                      ],
                      if (withInput) ...[
                        globalText(
                          textInput!,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (textInput != null) setHeightSpace(20),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: textFiled(
                            input,
                            label: textPlaceInput,
                            valdator: validator,
                            max: null,
                            min: inputMinLine,
                            withBorder: false,
                            type: TextInputType.multiline,
                          ),
                        ),
                        setHeightSpace(10),
                      ],
                      if (withImages) ...[
                        Container(
                          height: 100,
                          child: GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              mainAxisExtent: 100,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            itemCount: v.pickeds.length + 1,
                            itemBuilder: (context, index) {
                              if (v.pickeds.length <= index)
                                return InkWell(
                                  onTap: () async {
                                    var res = await selectImagePopUp(context);
                                    if (res != null && res['is_picked'])
                                      v.setFiles(res['pickeds']);
                                  },
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color: index == 0
                                            ? AppColor.orange
                                            : AppColor.secondary,
                                        width: 0.5,
                                      ),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(25),
                                      child: Icon(
                                        Icons.add,
                                        color: AppColor.orange,
                                      ),
                                    ),
                                  ),
                                );

                              XFile file = v.pickeds[index];
                              return InkWell(
                                onTap: () => NavMove.goToPage(context,
                                    ImageShowPage(v.pickeds, index: index)),
                                child: Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                      color: index == 0
                                          ? AppColor.orange
                                          : AppColor.secondary,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        child: Center(
                                          child: Image.file(File(file.path)),
                                        ),
                                      ),
                                      PositionedDirectional(
                                        top: 0,
                                        end: 0,
                                        child: InkWell(
                                          onTap: () => v.removeFile(file),
                                          child: Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(90),
                                              color: Colors.white,
                                              border: Border.all(
                                                color: AppColor.orange,
                                                width: 1,
                                              ),
                                            ),
                                            child: Icon(
                                              Icons.delete_outline,
                                              color: AppColor.orange,
                                              // width: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                      if (withDate) ...[
                        if (dateText != null) globalText(dateText!),
                        SfDateRangePicker(
                          selectionMode: DateRangePickerSelectionMode.single,
                          selectionColor: AppColor.orange,
                          headerStyle: DateRangePickerHeaderStyle(
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(color: AppColor.orange),
                          ),
                          monthViewSettings: DateRangePickerMonthViewSettings(
                            viewHeaderStyle: DateRangePickerViewHeaderStyle(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColor.orange,
                                fontSize: 10,
                              ),
                            ),
                          ),
                          initialSelectedDate: selectedDate,
                          minDate: DateTime.now(),
                          onSelectionChanged:
                              (DateRangePickerSelectionChangedArgs date) {
                            selectedDate = date.value;
                          },
                        ),
                      ],
                      if (widgets != null && widgets!.length > 0) ...[
                        setHeightSpace(10),
                        for (Widget widget in widgets!) widget,
                      ],
                      setHeightSpace(20),
                      Row(
                        children: [
                          if (showNo)
                            Expanded(
                              child: globalButton(
                                noText ?? S.current.cancel,
                                () => NavMove.goBack(context),
                                backColor: Colors.transparent,
                                textColor: Colors.red,
                                borderColor: Colors.red,
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ),
                          if (showNo && showYes) setWithSpace(10),
                          if (showYes)
                            Expanded(
                              child: globalButton(
                                yesText ?? S.current.confirm,
                                () {
                                  if (validator != null) {
                                    if (!formKey.currentState!.validate())
                                      return;
                                  }
                                  if (numberValidator != null) {
                                    if (!formKey.currentState!.validate())
                                      return;
                                  }

                                  if (withImages && minImageCount > 0) {
                                    if (v.pickeds.length < minImageCount)
                                      return screenMessage(
                                          S.current.pleaseAddImage);
                                  }

                                  if (withRate) {
                                    if (rate == 0) {
                                      return screenMessage(
                                          S.current.pleaseRate);
                                    }
                                  }

                                  NavMove.goBack(context, data: {
                                    'choose': true,
                                    'input': input.text,
                                    'number': number.text,
                                    'rate': rate,
                                    'date': selectedDate.toString(),
                                  });
                                },
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
