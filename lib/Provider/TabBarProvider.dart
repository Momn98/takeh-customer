import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takeh_customer/Api/HomeApi.dart';
import 'package:takeh_customer/Models/Applang.dart';
import 'package:takeh_customer/Models/Appsetting.dart';
import 'package:takeh_customer/Models/Country.dart';
import 'package:takeh_customer/Shared/SharedManaged.dart';

class TabBarProvider extends ChangeNotifier {
  HomeApi _api = HomeApi();

  TabBarProvider() {
    start();
  }

  start() async {
    await getLanguage();
    _getCountry();
    _getCurrency();
    // _getThemeData();
    await _getSetting();
    return;
  }

  Appsetting setting = Appsetting();

  List<Country> countrys = [];
  List<Applang> applangs = [];

  _getSetting() {
    _api.getAppSetting().then((value) {
      this.setting = value['setting'];
      this.countrys = value['countrys'];
      this.applangs = value['applangs'];
      notifyListeners();
    });
  }

  Locale locale = Locale('en', '');
  bool isRTL = false;

  Future getLanguage() async {
    String whichLanguage = '';
    await SharedPreferences.getInstance().then((value) {
      whichLanguage = value.getString(SharedKeys.language) ?? 'en';
      this.locale = Locale(whichLanguage, '');
      whichLanguage == 'ar' ? isRTL = true : isRTL = false;
      notifyListeners();
    });

    return whichLanguage;
  }

  changeLanguage(Applang applang) async {
    await SharedPreferences.getInstance().then((value) {
      value.setString(SharedKeys.language, applang.code);
      this.locale = Locale(applang.code, '');
      applang.code == 'ar' ? isRTL = true : isRTL = false;
    });

    notifyListeners();
  }

  // ThemeData _themeData = ThemeData.light();
  // ThemeData get themeData => _themeData;
  // bool isDark = false;

  // _getThemeData() {
  //   ThemeData whichTheme = ThemeData.light();
  //   SharedPreferences.getInstance().then((value) {
  //     whichTheme = value.getBool(SharedKeys.isDarkEnable) ?? false
  //         ? ThemeData.dark()
  //         : ThemeData.light();
  //     isDark = value.getBool(SharedKeys.isDarkEnable) ?? false;
  //     this._themeData = whichTheme;

  //     notifyListeners();
  //   });
  // }

  // changeThemeData() async {
  //   await SharedPreferences.getInstance().then((value) {
  //     if (this._themeData == ThemeData.dark())
  //       this._themeData = ThemeData.light();
  //     else
  //       this._themeData = ThemeData.dark();
  //     value.setBool(SharedKeys.isDarkEnable, !this.isDark);
  //   });
  //   this.isDark = !this.isDark;
  //   notifyListeners();
  // }

  final ImagePicker picker = ImagePicker();

  List<XFile> _pickeds = [];
  List<XFile> get pickeds => _pickeds;
  set pickeds(List<XFile> pickeds) {
    _pickeds = pickeds;
    notifyListeners();
  }

  bool _is_picked = false;
  bool get is_picked => _is_picked;
  set is_picked(bool is_picked) {
    _is_picked = is_picked;
    notifyListeners();
  }

  setFiles(List<XFile> files) {
    this.pickeds = files;
    notifyListeners();
  }

  addFile(XFile file) {
    this.pickeds.add(file);
    notifyListeners();
  }

  removeFile(XFile picked) {
    this.pickeds.remove(picked);
    notifyListeners();
  }

  String country = 'jordan';

  List<DropdownMenuItem> countrys_en = [
    DropdownMenuItem<String>(value: 'jordan', child: Text('Jordan')),
    // DropdownMenuItem<String>(value: 'syria', child: Text('Syria')),
  ];
  List<DropdownMenuItem> countrys_ar = [
    DropdownMenuItem<String>(value: 'jordan', child: Text('الاردن')),
    // DropdownMenuItem<String>(value: 'syria', child: Text('سوريا')),
  ];

  _getCountry() {
    String whichCountry = '';
    SharedPreferences.getInstance().then((value) {
      whichCountry = value.getString(SharedKeys.country) ?? 'jordan';
      this.country = whichCountry;
      notifyListeners();
    });
  }

  changeCountry(String newCountry) async {
    await SharedPreferences.getInstance().then((value) {
      value.setString(SharedKeys.country, newCountry);
      this.country = newCountry;
    });

    notifyListeners();
  }

  String currency = '';

  _getCurrency() {
    String whichCurrency = '';
    SharedPreferences.getInstance().then((value) {
      whichCurrency = value.getString(SharedKeys.currency) ?? 'JOD';
      this.currency = whichCurrency;
      notifyListeners();
    });
  }

  changeCurrency(String newCurrency) async {
    await SharedPreferences.getInstance().then((value) {
      value.setString(SharedKeys.currency, newCurrency);
      this.currency = newCurrency;
    });

    notifyListeners();
  }
}
