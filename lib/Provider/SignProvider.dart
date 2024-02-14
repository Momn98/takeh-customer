import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SignProvider extends ChangeNotifier {
  SignProvider() {
    clear();
  }

  clear() {
    isLogin = true;
    formKeyLogin = new GlobalKey<FormState>();
    formKeySignUp = new GlobalKey<FormState>();
    number = PhoneNumber(isoCode: 'JO');
    _acceptTerms = false;
    _errorAcceptTerms = false;

    // pass = TextEditingController();
  }

  bool isLogin = true;
  GlobalKey<FormState> formKeyLogin = new GlobalKey<FormState>();
  GlobalKey<FormState> formKeySignUp = new GlobalKey<FormState>();
  PhoneNumber number = PhoneNumber(isoCode: 'JO');

  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  // TextEditingController pass = TextEditingController();

  bool _acceptTerms = false;
  bool get acceptTerms => _acceptTerms;
  set acceptTerms(bool acceptTerms) {
    _acceptTerms = acceptTerms;
    errorAcceptTerms = false;
    notifyListeners();
  }

  bool _errorAcceptTerms = false;
  bool get errorAcceptTerms => _errorAcceptTerms;
  set errorAcceptTerms(bool errorAcceptTerms) {
    _errorAcceptTerms = errorAcceptTerms;
    notifyListeners();
  }
}
