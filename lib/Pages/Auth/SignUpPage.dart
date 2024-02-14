import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:takeh_customer/Pages/Stander-Pages/PoliciesPage.dart';
import 'package:takeh_customer/Provider/SignProvider.dart';
import 'package:takeh_customer/Global/HomeAppBar.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:takeh_customer/Global/input.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // @override
  // void initState() {
  //   signProvider.clear();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignProvider>(
      builder: (_, v, __) {
        return GlobalSafeArea(
          appBar: HomeAppBar(text: S.current.hello),
          body: Container(
            child: Form(
              key: v.formKeySignUp,
              child: Column(
                children: [
                  //
                  setHeightSpace(20),
                  //
                  globalText(
                    S.current.addYourDetailsToUseOurApp,
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  //
                  setHeightSpace(30),
                  //
                  Row(
                    children: [
                      Expanded(
                        child: authTextFiled(
                          v.fName,
                          label: S.current.fName,
                          validator: (value) => value!.isNotEmpty
                              ? null
                              : S.current.enterValidName,
                        ),
                      ),
                      //
                      setWithSpace(15),
                      //
                      Expanded(
                        child: authTextFiled(
                          v.lName,
                          label: S.current.lName,
                          validator: (value) => value!.isNotEmpty
                              ? null
                              : S.current.enterValidName,
                        ),
                      ),
                    ],
                  ),
                  //
                  setHeightSpace(15),
                  //
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (val) {},
                      isEnabled: false,
                      initialValue: v.number,
                      inputDecoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        hintText: S.current.phoneNumber,
                        border: border(AppColor.secondary),
                        focusedBorder: border(AppColor.orange),
                        enabledBorder: border(AppColor.orange),
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
                  //
                  setHeightSpace(15),

                  Row(
                    children: [
                      InkWell(
                        onTap: () => v.acceptTerms = !v.acceptTerms,
                        child: Icon(
                          v.acceptTerms
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          size: 20,
                          color: v.errorAcceptTerms
                              ? hexToColor('#C00202')
                              : v.acceptTerms
                                  ? Colors.green
                                  : Colors.black,
                        ),
                      ),
                      setWithSpace(10),
                      InkWell(
                        onTap: () => NavMove.goToPage(
                            context, PoliciesPage(page: 'terms')),
                        child: Row(
                          children: [
                            Text(
                              S.current.acceptTerms1,
                              style: TextStyle(
                                color: v.errorAcceptTerms
                                    ? hexToColor('#C00202')
                                    : Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            setWithSpace(5),
                            Text(
                              S.current.acceptTerms2,
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),

                  setHeightSpace(20),
                  Container(
                    width: double.infinity,
                    child: globalButton(
                      S.current.okayAndContinue,
                      fontWeight: FontWeight.normal,
                      mainAxisAlignment: MainAxisAlignment.center,
                      () async {
                        FocusScope.of(context).unfocus();

                        if (!v.formKeySignUp.currentState!.validate()) return;
                        if (!v.acceptTerms) {
                          screenMessage(S.current.pleaseAcceptTerms);
                          v.errorAcceptTerms = true;
                          return;
                        }

                        Map data = {
                          'first_name': v.fName.text.toString(),
                          'last_name': v.lName.text.toString(),
                          'phone': v.number.phoneNumber.toString(),
                        };

                        NavMove.goOTPPage(context, data, false);

                        // await authProvider.chickThe(
                        //   context,
                        //   isByLogin: false,
                        //   {
                        //     'first_name': v.fName.text.toString(),
                        //     'last_name': v.lName.text.toString(),
                        //     'phone': v.number.phoneNumber.toString(),
                        //     // 'password': v.pass.text.toString(),
                        //   },
                        // );

                        // return await authProvider.signUp(
                        //     context,
                        //     {
                        //       'first_name': v.fName.text.toString(),
                        //       'last_name': v.lName.text.toString(),
                        //       'phone': v.number.phoneNumber.toString(),
                        //       // 'password': v.pass.text.toString(),
                        //     },
                        //     false);
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
