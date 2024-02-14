class SharedManager {
  static final SharedManager shared = SharedManager._internal();

  factory SharedManager() {
    return shared;
  }
  SharedManager._internal();

  int currentIndex = 0;
  String token = '';
  String currency = '';
}

class SharedKeys {
  //
  static const String token = 'User-Token';
  //
  static const String isLogedIn = 'Is-loged-in';
  static const String isFirstTime = 'Is-first-time';
  // static const String pushToken = 'User-fire-base-token';
  static const String language = 'The-Language';
  static const String currency = 'The-Currency';
  static const String country = 'The-Country';
  // static const String isDarkEnable = 'Is-Dark-Theme-Enable';
  static const String selectedAddressId = 'The-Selected-Address-Id';
  // static const String productsLayout = 'Products-Layout';
}
