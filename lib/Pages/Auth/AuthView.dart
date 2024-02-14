import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:takeh_customer/Global/HomeAppBar.dart';
import 'package:takeh_customer/Global/input.dart';
import 'package:takeh_customer/Pages/Auth/okayAndContinuePopUp.dart';
import 'package:takeh_customer/Provider/AuthProvider.dart';
import 'package:takeh_customer/Provider/SignProvider.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:takeh_customer/main.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);
  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  PhoneNumber number = PhoneNumber(isoCode: 'JO');

  @override
  void initState() {
    signProvider.clear();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SignProvider, AuthProvider>(
      builder: (_, v, av, __) {
        return GlobalSafeArea(
          appBar: HomeAppBar(text: S.current.hello),
          body: Container(
            child: Form(
              key: v.formKeyLogin,
              child: Column(
                children: [
                  setHeightSpace(20),
                  globalText(
                    S.current.addYourYumberNowWillSendYouOtpCode,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  setHeightSpace(30),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (val) {
                        number = val;
                        v.number = number;
                      },
                      initialValue: number,
                      inputDecoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        hintText: S.current.phoneNumber,
                        border: border(Colors.grey),
                        focusedBorder: border(Colors.grey),
                        enabledBorder: border(Colors.grey),
                        errorBorder: border(Colors.red),
                        disabledBorder: border(Colors.grey),
                      ),
                      errorMessage: S.current.phoneNumberNotValid,
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.DIALOG,
                        setSelectorButtonAsPrefixIcon: true,
                        leadingPadding: 10,
                        useEmoji: true,
                      ),
                    ),
                  ),
                  setHeightSpace(15),
                  Spacer(),
                  globalText(
                    S.current
                        .readOurPrivacyPolicyClickOnOkayAndContinueForTheTermsAndConditions,
                    textAlign: TextAlign.center,
                  ),
                  setHeightSpace(20),
                  Container(
                    width: double.infinity,
                    child: globalButton(
                      S.current.okayAndContinue,
                      fontWeight: FontWeight.normal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      () async {
                        FocusScope.of(context).unfocus();

                        if (v.formKeyLogin.currentState!.validate()) {
                          var res = await okayAndContinuePopUp(context);

                          if (res == null) return;
                          if (!res['continue']) return v.clear();

                          await authProvider.chickThe(
                            context,
                            {'phone': v.number.phoneNumber},
                          );

                          // if (!av.showPassword) {
                          //   await authProvider.chickThe(
                          //     context,
                          //     {'phone': v.number.phoneNumber},
                          //   );
                          // } else {
                          //   await authProvider.logIn(
                          //     context,
                          //     {
                          //       'phone': v.number.phoneNumber,
                          //       'password': v.pass.text.toString(),
                          //     },
                          //     true,
                          //   );
                          // }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
