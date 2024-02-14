import 'dart:async';

import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

InputBorder border(Color color) => UnderlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 1),
    );

InputBorder outline_border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color, width: 1),
    );

Widget authTextFiled(
  TextEditingController controller, {
  String? label,
  TextStyle labelStyle = const TextStyle(),
  String? hint,
  TextInputType? keyboardType = TextInputType.name,
  TextDirection? textDirection,
  bool? enabled,
  bool onlyNumber = false,
  Function(String)? onChanged,
  String? Function(String?)? validator,
  bool obscureText = false,
  void Function()? onTap,
}) {
  return TextFormField(
    onTap: onTap,
    obscureText: obscureText,
    enabled: enabled,
    onChanged: onChanged,
    validator: validator ??
        (val) {
          if (val!.length < 1) return S.current.required;
          return null;
        },
    textInputAction: TextInputAction.next,
    textDirection: textDirection,
    keyboardType: !onlyNumber ? keyboardType : TextInputType.number,
    inputFormatters: onlyNumber
        ? <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp('[0.00-9.99]')),
          ]
        : null,
    controller: controller,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 10),
      labelText: label,
      labelStyle: labelStyle.copyWith(color: Colors.black),
      hintText: hint,
      border: outline_border(AppColor.orange),
      focusedBorder: outline_border(Colors.grey),
      enabledBorder: outline_border(Colors.grey),
      errorBorder: outline_border(Colors.red),
      disabledBorder: outline_border(Colors.grey),
    ),
  );
}

Widget textFiled(
  TextEditingController controller, {
  String? hint,
  TextStyle? hintStyle,
  String? label,
  String? Function(String? value)? valdator,
  TextInputType type = TextInputType.name,
  double marginHorizontal = 0,
  double paddingHorizontal = 0,
  double radius = 10,
  int? max = 1,
  int? min = 1,
  bool? enabled = true,
  Widget? icon,
  double? height,
  double? width,
  Color? labelColor,
  bool withHintText = true,
  bool withLabelText = true,
  bool onlyNumber = false,
  bool iconAtStart = false,
  TextAlign textAlign = TextAlign.start,
  bool withBorder = true,
  void Function(String)? onChanged,
  void Function()? onEditingComplete,
  FocusNode? focusNode,
  String borderType = 'border',
  int? maxLength,
}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: marginHorizontal),
    padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
    height: height,
    width: width,
    child: Row(
      children: [
        if (iconAtStart && icon != null) ...[
          icon,
          setWithSpace(10),
        ],
        Expanded(
          child: TextFormField(
            onChanged: onChanged,
            onEditingComplete: onEditingComplete,
            enabled: enabled,
            maxLines: max,
            minLines: min,
            maxLength: maxLength,
            controller: controller,
            focusNode: focusNode,
            validator: valdator,
            keyboardType: type,
            inputFormatters: onlyNumber
                ? <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp('[0.0-9.9]')),
                  ]
                : null,
            textAlign: textAlign,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              hintText: withHintText ? hint : null,
              hintStyle: hintStyle,
              labelText: withLabelText ? label : null,
              border: withBorder
                  ? borderType == 'border'
                      ? border(AppColor.orange)
                      : outline_border(AppColor.orange)
                  : InputBorder.none,
              focusedBorder: withBorder
                  ? borderType == 'border'
                      ? border(Colors.grey)
                      : outline_border(Colors.grey)
                  : InputBorder.none,
              enabledBorder: withBorder
                  ? borderType == 'border'
                      ? border(Colors.grey)
                      : outline_border(Colors.grey)
                  : InputBorder.none,
              errorBorder: withBorder
                  ? borderType == 'border'
                      ? border(Colors.red)
                      : outline_border(Colors.red)
                  : InputBorder.none,
              disabledBorder: withBorder
                  ? borderType == 'border'
                      ? border(Colors.grey)
                      : outline_border(Colors.grey)
                  : InputBorder.none,
            ),
          ),
        ),
        if (!iconAtStart && icon != null) icon,
      ],
    ),
  );
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class Debouncer {
  final int seconds;
  VoidCallback action;
  Timer? timer;

  Debouncer({
    required this.seconds,
    required this.action,
  });

  run(VoidCallback action) {
    if (timer != null) timer!.cancel();

    timer = Timer(Duration(seconds: seconds), action);
  }
}

Future<bool> isItGoodToSearch(
    {required String value,
    required String searchedText,
    required TextEditingController search}) async {
  if (value == '' || value.length < 3 || value == searchedText) return false;
  if (search.text == '' ||
      search.text.length < 3 ||
      search.text == searchedText) return false;

  return true;
}
