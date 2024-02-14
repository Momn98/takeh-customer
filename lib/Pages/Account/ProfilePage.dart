import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:takeh_customer/Global/HomeAppBar.dart';
import 'package:takeh_customer/Global/input.dart';
import 'package:takeh_customer/Global/selectImagePopUp.dart';
import 'package:takeh_customer/Models/User.dart';
import 'package:takeh_customer/Provider/AuthProvider.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:takeh_customer/main.dart';
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user = authProvider.user;

  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController birthDay = TextEditingController();
  TextEditingController selectGender = TextEditingController();
  DateTime selectedDate = DateTime.now().add(Duration(days: 1));
  PhoneNumber number = PhoneNumber(isoCode: 'JO');

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    number = PhoneNumber(isoCode: 'JO', phoneNumber: user.phone);

    fName.text = user.firstName;
    lName.text = user.lastName;
    email.text = user.email;
    birthDay.text = user.birthDay;
    selectGender.text = user.gender;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalSafeArea(
      showBackground: true,
      appBar: HomeAppBar(text: S.current.personalInformation),
      body: Consumer<AuthProvider>(
        builder: (_, v, __) {
          return Form(
            key: _formKey,
            child: Column(
              children: [
                setHeightSpace(10),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: InkWell(
                    onTap: () async {
                      var res = await selectImagePopUp(context, onlyOne: true);

                      if (res != null && res['is_picked']) {
                        XFile file = res['pickeds'][0];
                        List<int> imageBytes = await file.readAsBytes();
                        String base64Image = base64Encode(imageBytes);
                        await authProvider.updateUserApi(context, {
                          'image': jsonEncode(base64Image),
                        });
                        setState(() {});
                      }
                    },
                    child: Stack(
                      children: [
                        ClipOval(
                          child: NetworkImagePlace(
                            image: v.user.image,
                            fit: BoxFit.cover,
                            all: 90,
                          ),
                        ),
                        PositionedDirectional(
                          end: 5,
                          bottom: 5,
                          child: Container(
                            child: Icon(Icons.camera),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                setHeightSpace(20),

                Row(
                  children: [
                    Expanded(
                      child: authTextFiled(
                        fName,
                        label: S.current.fName,
                      ),
                    ),
                    setWithSpace(10),
                    Expanded(
                      child: authTextFiled(
                        lName,
                        label: S.current.lName,
                      ),
                    ),
                  ],
                ),

                setHeightSpace(15),
                Expanded(
                  child: authTextFiled(
                    email,
                    label: S.current.email,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    DateTime? datePick = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(1900),
                      lastDate: selectedDate.add(Duration(days: 10000)),
                      cancelText: S.current.cancel,
                      confirmText: S.current.select,
                    );
                    if (datePick != null) {
                      setState(() {
                        selectedDate = datePick;
                        birthDay.text = datePick.toString().split(' ')[0];
                        // birthDay.text = DateFormat.yMMMEd().format(datePick);
                      });
                    }
                  },
                  child: textFiled(
                    hint: S.current.birthDay,
                    birthDay,
                    enabled: false,
                    icon: Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.black,
                    ),
                  ),
                ),
                setHeightSpace(15),
            Row(
  mainAxisAlignment: MainAxisAlignment.center, 
  children: [
    genderCard('male', 'male', IconSvg.male),
    SizedBox(width: 20), 
    genderCard('female', 'female', IconSvg.female),
  ],
),


                Directionality(
                  textDirection: TextDirection.ltr,
                  child: InternationalPhoneNumberInput(
                    isEnabled: false,
                    onInputChanged: (v) => null,
                    selectorTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    initialValue: number,
                    inputDecoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      hintText: S.current.phoneNumber,
                      border: border(Colors.white),
                      focusedBorder: border(Colors.grey.shade300),
                      enabledBorder: border(Colors.grey.shade300),
                      errorBorder: border(Colors.red),
                      disabledBorder: border(Colors.grey),
                      fillColor: Colors.white,
                      filled: true,
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

                setHeightSpace(70),
                //
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: globalText(
                    S.current.weWillNeverShareYourData,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 11,
                    ),
                  ),
                ),

                setHeightSpace(50),

                globalButton(S.current.update, () async {
                  FocusScope.of(context).unfocus();
                  if (this._formKey.currentState!.validate()) {
                    this._formKey.currentState!.save();
                    await authProvider.updateUserApi(context, {
                      'first_name': fName.text,
                      'last_name': lName.text,
                      'email': email.text,
                      'birth_day': birthDay.text,
                      'gender': selectGender.text,
                    });
                  }
                }),

                // setHeightSpace(30),
              ],
            ),
          );
        },
      ),
      //
    );
  }

  Widget genderCard(String text, String val, AssetImage image) {
    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() => selectGender.text = val.toString());
      },
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: selectGender == val ? Colors.red[100] : Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(15),
            child: Image(image: image),
          ),
          setHeightSpace(5),
          Text(
            text,
            style: TextStyle(
              color: selectGender == val ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
