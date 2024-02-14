import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class S implements WidgetsLocalizations {
  const S();

  static S current = S();

  static const GeneratedLocalizationsDelegate delegate =
      GeneratedLocalizationsDelegate();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => 'Takeh';
  String get tapBackAgain => 'Tap back again to exit';
  String get logIn => 'Log In';
  String get signUp => 'Sign Up';
  String get continueGuest => 'Continue Guest';
  String get loginToYourAccount => 'Login To Your Account';
  String get registrationYourAccount => 'Registration Your Account';

  String get jordan => 'Jordan';
  // String get syria => 'Syria';

  String get phoneNumber => 'Phone Number';
  String get phoneNumberNotValid => 'Phone Number Not Valid';
  String get thisFieldRequired => 'This Field Required';
  String get pleaseUpdateApp => 'Please Update App';

  String get home => 'Home';
  String get scan => 'Scan';
  String get support => 'Support';
  String get orders => 'Orders';
  String get profile => 'Profile';

  String get qrCode => 'Qr Code';
  String get myOrders => 'My Orders';

  //
  String get shareApp => 'Share App';
  String get account => 'Account';
  String get settings => 'Settings';
  String get aboutApp => 'About App';
  String get signOut => 'Sign Out';
  String get termsAndCondition => 'Terms & Condition';

  String get shareAppNow => 'Share The App Now';
  String get personalInformation => 'Personal Information';

  String get takeImage => 'Take Image';
  String get gallery => 'Gallery';
  String get camera => 'Camera';
  String get cancel => 'Cancel';
  String get done => 'Done';
  String get fName => 'First Name';
  String get lName => 'Last Name';

  String get weWillNeverShareYourData =>
      'We will not share your personal information, and will use it solely to personalize your experience in this app.';

  String get notifications => 'Notifications';
  String get language => 'Language';
  String get contactUs => 'Contact Us';
  String get privacyPolicy => 'Privacy Policy';
  String get deleteAccount => 'Delete Account';
  //
  String get noNotificationsHere => 'No Notifications Here';
  String get selectLanguage => 'Select Language';
  String get pleaseSelectYourPreferredLanguage =>
      'Please Select Your Preferred Language';

  String get mobileNumber => 'Mobile Number';
  String get email => 'Email';
  String get followUsOn => 'Follow Us On';
  String get moreInfoAboutApp => 'More Info About App';
  String get confirm => 'Confirm';

  String get theDelete => 'Delete Account';

  String get deleteThisAccount => 'Delete this account';
  String get doYouWantToDeleteThisAccount =>
      'Do you want to delete this account?';

  String get deleteParagraph =>
      'Delete your account only if you\'re certain you want to.\nYou will lose all of your prior data if you delete this account.\nThe erased data cannot be used to log into the application again.\nTo use Takeh application, you have to sign up for a new account.\nDue to the fact that it will be permanently removed from our server.\n\n\nIf you need assistance.';
  String get deleteEmail => 'info@takeh.com';
  String get deletePhone => '+962782562016';
  String get doYouWantToContinue => 'Do you want to continue?';
  String get confirmDeleteThisAccount => 'Confirm delete this account';
  String get yes => 'Yes';
  String get no => 'No';
  String get version => 'Version';
  String get copyright => 'Copyright';
  String get allRightsReserved => 'All Rights Reserved';

  String get sorryYourAccountBlocked => 'Sorry Your Account Blocked';
  String get pleaseContactUsToRemoveBlock =>
      'Please Contact Us To Remove Block';

  String get pleaseWait => 'Please Wait';

  String get resendCode => 'Resend Code';
  String get otpVerification => 'OTP Verification';
  String get codeHasBeenSentTo => 'Code Has Been Sent To';
  String get pleaseEnterTheCorrectOtpSentTo =>
      'Please Enter The Correct OTP Sent To';
  String get acceptTerms1 => 'Accept';
  String get acceptTerms2 => 'Terms & condition';

  String get pleaseAcceptTerms => 'Please, Accept Terms and Condition';

  String get enterValidName => 'Enter Valid Name';
  String get updated => 'Updated';

  String get searchForAddress => 'Search For Address';
  String get loading => 'Loading';
  String get searchForYourAddress => 'Search For Your Address';
  String get location => 'Location';
  String get deliverHere => 'Deliver Here';
  String get locationHere => 'Location Here';
  String get skip => 'Skip';

  //
  String get addNewAddress => 'Add New Address';
  String get address => 'Address';
  String get youDontHaveAnySavedAddress => 'You Dont Have Any Saved Address';
  String get doYouWantToDeleteThisAddress =>
      'Do You Want To Delete This Address?';
  String get delete => 'Delete';
  String get youCanChooseTheLocationUsingTheMap =>
      'You Can Choose The Location Using The Map';

  String get thisFieldIsRequired => 'This Field Is Required';

  String get building => 'Building';
  String get apartment => 'Apartment';
  String get saveAddress => 'Save Address';
  String get pleaseSelectLocation => 'Please Select Location';
  String get select => 'Select';

  String get locations => 'Locations';
  String get fromLocation => 'From Location';
  String get toLocation => 'To Location';
  String get selectedDate => 'Selected Date';
  String get time => 'Time';
  String get birthDay => 'Birthday';

  // String get rateTheCustomer => 'Rate The Customer';
  // String get howIsTheCustomer => 'How Is The Customer';
  String get enterLocationInfo => 'Enter Location Info';
  String get area => 'Area';
  String get note => 'Note';
  String get addLocation => 'Add Location';
  String get nick_name => 'Nick Name';
  String get street => 'Street';
  String get findingTheBestServiceProvider =>
      'Finding The Best Service Provider';
  String get rateTheServiceProvider => 'Rate The Service Provider';
  String get pleaseRate => 'Please Rate';
  String get howIsTheServiceProvider => 'How Is The Service Provider';
  String get apply => 'Apply';
  String get change => 'Change';
  String get jd => 'JD';
  String get hello => 'Hello';
  String get addYourYumberNowWillSendYouOtpCode =>
      'add your number,\nwe will send you otp code';
  String get readOurPrivacyPolicyClickOnOkayAndContinueForTheTermsAndConditions =>
      'Read our privacy policy, click on okay and continue for the terms and conditions';
  String get okayAndContinue => 'okay and continue';
  String get Continue => 'continue';
  String get chickPhoneNumber => 'Chick Phone Number';
  String get weWillChickThisPhoneNumber => 'we will chick this phone number';
  String get isPhoneNumberCorrectOrWantToChangeIt =>
      'is phone number correct? or want to change it?';
  String get trueContinue => 'true & continue';
  String get welcome => 'Welcome :)';
  String get aSmartUserHasJustDownloadedNourAppExcellent =>
      'a smart user has just downloaded\nour app. Excellent!';
  String get selectlanguage => 'Select language';
  String get selectYourCountry => 'Select your country';
  String get letsGetStarted => 'Let\'s Get Started';
  String get addYourDetailsToUseOurApp => 'add your details,\nTo use our app';
  String get promoCode => 'Promo Code';
  String get submit => 'Submit';
  String get submitYourOrder => 'Submit Your Order?';
  // String get cancel => 'Cancel';
  String get confirmCancelOrder => 'Confirm Cancel Order?';
  String get activeOrder => 'Active Order';
  String get historyOrders => 'History Orders';
  String get canceledOrders => 'Canceled Orders';
  String get contactUsTextLong =>
      'Thank you for contacting us, you will be transferred on WhatsApp for direct communication. Official working hours are from 9:00 am - 5:00 pm. Your message will be answered within 24 hours.';
  String get showBalance => 'Show Balance';
  String get availableBalance => 'Available Balance';
  String get userNotFound => 'User Not Found';
  String get phoneNumberNotRejecteredWithAnyUser =>
      'Phone number not registered with any user, please sign up to use our app';
  String get yourTotalPoints => 'Your Total Points';
  String get checking => 'Checking';
  String get orderPrice => 'Order Price';
  String get order => 'Order';
  String get theReasonOfCancelOrder => 'The Reason Of Cancel Order';
  String get orderID => 'Order ID';
  String get service => 'Service';
  String get noOrders => 'No Orders';
  String get pleaseEnableLocationService =>
      'Please Enable location service to find the nearest service provider to your location';
  String get appNeedsAccessToYourDevicesLocation =>
      'Takeh needs access to your device location in order to provide accurate provider services and ensure a seamless navigation experience. We will only collect and use your location data while the app is running in the background. \nThis allows us to match you with the nearest available service provider';
  //
  //
  String get back => 'Back';
  String get password => 'Password';
  String get min => 'Min';
  String get km => 'Km';

  String get type => 'Car Type';
  String get model => 'Car Model';
  String get year => 'Car Year';
  String get carNumber => 'Car Number';
  String get carColor => 'Car Color';

  String get pleaseUploadPersonalImage => 'Please Upload Personal Image';

  String get paymentType => 'Payment Type';
  String get cash => 'Cash';
  String get wallet => 'Wallet';
  String get moneyInWalletNotEnough => 'Money In Wallet Not Enough';
  String get close => 'Close';

  String get reorderItemDown => throw UnimplementedError();
  String get reorderItemLeft => throw UnimplementedError();
  String get reorderItemRight => throw UnimplementedError();
  String get reorderItemToEnd => throw UnimplementedError();
  String get reorderItemToStart => throw UnimplementedError();
  String get reorderItemUp => throw UnimplementedError();

  String get required => 'Required';
  String get pleaseAddImage => 'Please Add Image';

  String get cancelReason => 'Cancel Reason';

  String get other => 'Other';
  String get reason1 => 'I found another choice';
  String get reason2 => 'The service provider is far away';
  String get reason3 => 'I wrote the site wrong';
  String get reason4 => 'I waited a long time';
  String get reason5 => 'The service provider requested to cancel the order';
  String get discountedAmount => 'Discounted Amount';
  String get paidCash => 'paid Cash';
  String get paidWallet => 'paid Wallet';
  String get update => 'Update';
  String get Lookingforadriver => 'Looking for a driver';
  String get YALLA => 'YALLA';
}

class $ar extends S {
  const $ar();

  @override
  TextDirection get textDirection => TextDirection.rtl;

  @override
  String get appName => 'تكة';
  @override
  String get tapBackAgain => 'للخروج اكبس رجوع مرة اخرى';
  @override
  String get logIn => 'تسجيل الدخول';
  @override
  String get signUp => 'تسجيل';
  @override
  String get continueGuest => 'دخول كزائر';
  @override
  String get loginToYourAccount => 'تسجيل الدخول الى الحساب';
  @override
  String get registrationYourAccount => 'تسجيل حساب';
  @override
  String get jordan => 'الأردن';
  // @override
  // String get syria => 'سوريا';
  @override
  String get phoneNumber => 'رقم الهاتف';
  @override
  String get phoneNumberNotValid => 'رقم الهاتف غير صحيح';
  @override
  String get thisFieldRequired => 'هذا الحقل مطلوب';
  @override
  String get pleaseUpdateApp => 'الرجاء تحديث التطبيق';
  @override
  String get home => 'الرئيسية';
  @override
  String get scan => 'مسح';
  @override
  String get support => 'الدعم';
  @override
  String get orders => 'الطلبات';
  @override
  String get profile => 'الحساب';
  @override
  String get qrCode => 'مسح الرمز';
  @override
  String get myOrders => 'طلباتي';
  @override
  String get shareApp => 'مشاركة التطبيق';
  @override
  String get account => 'الحساب';
  @override
  String get settings => 'الاعدادات';
  @override
  String get aboutApp => 'عن التطبيق';
  @override
  String get signOut => 'تسجيل خروج';
  @override
  String get termsAndCondition => 'الشروط و الاحكام';
  @override
  String get shareAppNow => 'مشاركة التطبيق الان';
  @override
  String get personalInformation => 'المعلومات الشخصية';
  @override
  String get takeImage => 'التقاط صورة';
  @override
  String get gallery => 'المعرض';
  @override
  String get camera => 'الكاميرا';
  @override
  String get cancel => 'الغاء';
  @override
  String get done => 'تم';
  @override
  String get fName => 'الاسم الاول';
  @override
  String get lName => 'اسم العائلة';
  @override
  String get weWillNeverShareYourData =>
      'لن نشارك معلوماتك الشخصية ، وسنستخدمها فقط لتخصيص تجربتك في هذا التطبيق.';
  @override
  String get notifications => 'الاشعارات';
  @override
  String get language => 'اللغة';
  @override
  String get contactUs => 'تواصل معنا';
  @override
  String get privacyPolicy => 'سياسة الخصوصية';
  @override
  String get deleteAccount => 'حذف الحساب';
  @override
  String get noNotificationsHere => 'لا يوجد اشعارات ';
  @override
  String get selectLanguage => 'اختر اللغة';
  @override
  String get pleaseSelectYourPreferredLanguage => 'يرجى تحديد لغتك المفضلة';
  @override
  String get mobileNumber => 'رقم الهاتف';
  @override
  String get email => 'البريد الالكتروني';
  @override
  String get followUsOn => 'تابعنا هنا';
  @override
  String get moreInfoAboutApp => 'مزيد من المعلومات حول التطبيق';
  @override
  String get confirm => 'تأكيد';
  @override
  String get birthDay => 'تاريخ الميلاد';
  @override
  String get theDelete => 'حذف الحساب';
  @override
  String get deleteThisAccount => 'حذف هذا الحساب';
  @override
  String get doYouWantToDeleteThisAccount => 'هل تريد حذف هذا الحساب؟';
  @override
  String get deleteParagraph =>
      'احذف حسابك فقط إذا كنت متأكدًا من رغبتك في ذلك. \n ستفقد جميع بياناتك السابقة إذا قمت بحذف هذا الحساب. \n لا يمكن استخدام البيانات التي تم مسحها لتسجيل الدخول إلى التطبيق مرة أخرى. \n لاستخدام تطبيق Takeh ، أنت يجب عليك التسجيل للحصول على حساب جديد. \n نظرًا لحقيقة أنه سيتم إزالته نهائيًا من الخادم الخاص بنا. \n \n \n إذا كنت بحاجة إلى المساعدة.';
  @override
  String get deleteEmail => 'info@takeh.com';
  @override
  String get deletePhone => 'حذف الرقم';
  @override
  String get doYouWantToContinue => 'هل تريد الاستمرار ؟';
  @override
  String get confirmDeleteThisAccount => 'تأكيد حذف الحساب';
  @override
  String get yes => 'نعم';
  @override
  String get no => 'لا';
  @override
  String get version => 'الأصدار';
  @override
  String get copyright => 'Copyright';
  @override
  String get allRightsReserved => 'جميع الحقوق محفوظة';
  @override
  String get sorryYourAccountBlocked => 'عذراً ، حسابك محظور';
  @override
  String get pleaseContactUsToRemoveBlock => 'الرجاء التواصل معنا لازالة الحظر';
  @override
  String get pleaseWait => 'الرجاء الانتظار';
  @override
  String get resendCode => 'اعادة ارسال';
  @override
  String get otpVerification => 'رمز التحقق';
  @override
  String get codeHasBeenSentTo => 'تم ارسال الرمز الى';
  @override
  String get pleaseEnterTheCorrectOtpSentTo =>
      'الرجاء ادخال رمز التحقق المرسل الى';
  @override
  String get acceptTerms1 => 'الموافقة';
  @override
  String get acceptTerms2 => 'على الشروط والاحكام';
  @override
  String get pleaseAcceptTerms => 'الرجاء الموافقة على الشروط والاحكام';
  @override
  String get enterValidName => 'ادخل الاسم الصحيح';
  @override
  String get updated => 'تم التحديث';
  @override
  String get searchForAddress => 'البحث عن عنوان';
  @override
  String get loading => 'تحميل';
  @override
  String get searchForYourAddress => 'البحث عن عنوانك';
  @override
  String get location => 'الموقع';
  @override
  String get deliverHere => 'تسليم هنا';
  @override
  String get locationHere => 'الموقع هنا';
  @override
  String get skip => 'تخطي';

  @override
  String get addNewAddress => 'اضافة موقع جديد';
  @override
  String get address => 'الموقع';
  @override
  String get youDontHaveAnySavedAddress => 'ليس لديك أي عنوان محفوظ';
  @override
  String get doYouWantToDeleteThisAddress => 'هل تريد حذف هذا العنوان؟';
  @override
  String get delete => 'حذف';
  @override
  String get youCanChooseTheLocationUsingTheMap =>
      'يمكنك اختيار الموقع باستخدام الخريطة';
  @override
  String get thisFieldIsRequired => 'هذا الحقل مطلوب';
  @override
  String get building => 'اسم البناية';
  @override
  String get apartment => 'رقم الشقة';
  @override
  String get saveAddress => 'حفظ الموقع';
  @override
  String get pleaseSelectLocation => 'يرجى تحديد الموقع';
  @override
  String get select => 'اختيار';
  @override
  String get locations => 'الموقع';
  @override
  String get fromLocation => 'من الموقع';
  @override
  String get toLocation => 'الى الموقع';
  @override
  String get selectedDate => 'اختر الوقت';
  @override
  String get time => 'الوقت';
  // @override
  // String get rateTheCustomer => 'تقييم الزبون';
  // @override
  // String get howIsTheCustomer => 'كيف كانت معاملة الزبون';
  @override
  String get enterLocationInfo => 'أدخل معلومات الموقع';
  @override
  String get area => 'المنطقة';
  @override
  String get note => 'ملاحظات';
  @override
  String get addLocation => 'اضافة موقع';
  @override
  String get nick_name => 'اسم الموقع';
  @override
  String get street => 'اسم الشارع';
  @override
  String get findingTheBestServiceProvider => 'العثور على أفضل مزود خدمة';
  @override
  String get rateTheServiceProvider => 'قيم مزود الخدمة';
  @override
  String get pleaseRate => 'الرجاء التقييم';
  @override
  String get howIsTheServiceProvider => 'كيف كانت معاملة مزود الخدمة';
  @override
  String get apply => 'تفعيل';
  @override
  String get change => 'تغيير';
  @override
  String get jd => 'د.أ';
  @override
  String get hello => 'مرحباً';
  @override
  String get addYourYumberNowWillSendYouOtpCode =>
      'أضف رقمك ، \n سنرسل لك رمز otp';
  @override
  String get readOurPrivacyPolicyClickOnOkayAndContinueForTheTermsAndConditions =>
      'اقرأ سياسة الخصوصية الخاصة بنا ، وانقر فوق موافق وتابع للشروط والأحكام';
  @override
  String get okayAndContinue => 'موافقة واستمرار';
  @override
  String get Continue => 'أكمل';
  @override
  String get chickPhoneNumber => 'تأكيد رقم الهاتف';
  @override
  String get weWillChickThisPhoneNumber => 'سوف نتحقق من رقم الهاتف هذا';
  @override
  String get isPhoneNumberCorrectOrWantToChangeIt =>
      'هل رقم الهاتف صحيح؟ أو تريد تغييره؟';
  @override
  String get trueContinue => 'موافق واستمرار';
  @override
  String get welcome => 'مرحباً :)';
  @override
  String get aSmartUserHasJustDownloadedNourAppExcellent =>
      'قام مستخدم  بتنزيل \n تطبيقنا للتو. ممتاز!';
  @override
  String get selectlanguage => 'اختر اللغة';
  @override
  String get selectYourCountry => 'اختر البلد';
  @override
  String get letsGetStarted => 'هيا بنا نبدأ';
  @override
  String get addYourDetailsToUseOurApp =>
      'أضف التفاصيل الخاصة بك ، \n لاستخدام التطبيق لدينا';
  @override
  String get promoCode => 'كود الخصم';
  @override
  String get submit => 'تقديم';
  @override
  String get submitYourOrder => 'تقديم طلبك؟';
  // @override
  // String get cancele => 'الغاء';
  @override
  String get confirmCancelOrder => 'تأكيد إلغاء الطلب؟';
  @override
  String get activeOrder => 'الطلبات الفعالة';
  @override
  String get historyOrders => 'الطلبات السابقة';
  @override
  String get canceledOrders => 'الطلبات الملغية';
  @override
  String get contactUsTextLong =>
      'شكرا لتواصلك معنا ، سيتم نقلك على WhatsApp للتواصل المباشر. ساعات العمل الرسمية من 9:00 ص - 5:00 م. سيتم الرد على رسالتك في غضون 24 ساعة.';
  @override
  String get showBalance => 'إضهار الرصيد';
  @override
  String get availableBalance => 'الرصيد الحالي';
  @override
  String get userNotFound => 'لم يتم العثور على المستخدم';
  @override
  String get phoneNumberNotRejecteredWithAnyUser =>
      'رقم الهاتف لم يتم ربطه مع أي مستخدم ، يرجى التسجيل لاستخدام التطبيق لدينا';

  @override
  String get yourTotalPoints => 'مجموع نقاطك';
  @override
  String get checking => 'جاري البحث';
  @override
  String get orderPrice => 'تكلفة الطلب';
  @override
  String get order => 'طلب';
  @override
  String get theReasonOfCancelOrder => 'سبب إلغاء الطلب';
  @override
  String get orderID => 'رقم الطلب';
  @override
  String get service => 'الخدمات';
  @override
  String get noOrders => 'لا يوجد طلبات';
  @override
  String get pleaseEnableLocationService =>
      'يرجى تمكين خدمة الموقع للعثور على أقرب مزود خدمة لموقعك';
  @override
  String get appNeedsAccessToYourDevicesLocation =>
      '. يحتاج Takeh إلى الوصول إلى موقع جهازك من أجل تقديم خدمات موفرة دقيقة وضمان تجربة تنقل سلسة سنقوم فقط بجمع واستخدام بيانات موقعك أثناء تشغيل التطبيق في الخلفية, هذا يسمح لنا بمطابقتك مع أقرب مزود خدمة متاح';
  @override
  String get back => 'رجوع';
  @override
  String get password => 'كلمة المرور';

  @override
  String get type => 'نوع السيارة';
  @override
  String get model => 'موديل السيارة';
  @override
  String get year => 'سنة السيارة';
  @override
  String get carNumber => 'رقم السياره';
  @override
  String get carColor => 'لون السيارة';

  @override
  String get pleaseUploadPersonalImage => 'يرجى تحميل الصورة الشخصية';

  @override
  String get paymentType => 'طريقة الدفع ';
  @override
  String get cash => 'نقدي';
  @override
  String get wallet => 'المحفظة';
  @override
  String get moneyInWalletNotEnough => 'الرصيد غير كافي في المحفظة';
  @override
  String get close => 'اغلاق';

  @override
  String get required => 'مطلوب';
  @override
  String get pleaseAddImage => 'الرجاء إضافة الصورة';
  @override
  String get cancelReason => 'سبب الإلغاء';

  @override
  String get other => 'أخرى';

  @override
  String get reason1 => 'لقد وجدت خيار أخر';
  @override
  String get reason2 => 'مزود الخدمة بعيد';
  @override
  String get reason3 => 'كتبت الموقع خطأ';
  @override
  String get reason4 => 'انتظرت فترة طويلة';
  @override
  String get reason5 => 'طلب مزود الخدمة إلغاء الطلب';
  @override
  String get update => 'تعديل';
  String get discountedAmount => 'قيمة الخصم ';
  String get paidCash => 'دفع نقداَ';
  String get paidWallet => 'دفع عبر المحفظة';
    String get Lookingforadriver => 'البحث عن السائق';
    String get YALLA => 'يلا';

}

class $en extends S {
  const $en();
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<S> {
  const GeneratedLocalizationsDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale('ar', ''),
      Locale('en', ''),
    ];
  }

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<S> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    final String lang = getLang(locale);

    switch (lang) {
      case 'ar':
        S.current = const $ar();
        return SynchronousFuture<S>(S.current);
      //
      case 'en':
        S.current = const $en();
        return SynchronousFuture<S>(S.current);
      default:
      // NO-OP.
    }

    S.current = const S();
    return SynchronousFuture<S>(S.current);
  }

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => false;
}

String getLang(Locale l) => l.languageCode;
