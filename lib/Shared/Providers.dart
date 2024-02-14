import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:takeh_customer/Provider/AddressProvider.dart';
import 'package:takeh_customer/Provider/AuthProvider.dart';
import 'package:takeh_customer/Provider/HomeProvider.dart';
import 'package:takeh_customer/Provider/LocationProvider.dart';
import 'package:takeh_customer/Provider/OrderProvider.dart';
import 'package:takeh_customer/Provider/UserRealTimeProvider.dart';
import 'package:takeh_customer/Provider/QrCodeProvider.dart';
import 'package:takeh_customer/Provider/RealTimeProvider.dart';
import 'package:takeh_customer/Provider/SignProvider.dart';
import 'package:takeh_customer/Provider/TabBarProvider.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<TabBarProvider>.value(value: TabBarProvider()),
  ChangeNotifierProvider<AuthProvider>.value(value: AuthProvider()),
  ChangeNotifierProvider<SignProvider>.value(value: SignProvider()),
  ChangeNotifierProvider<HomeProvider>.value(value: HomeProvider()),
  ChangeNotifierProvider<QrCodeProvider>.value(value: QrCodeProvider()),
  ChangeNotifierProvider<LocationProvider>.value(value: LocationProvider()),
  ChangeNotifierProvider<OrderProvider>.value(value: OrderProvider()),
  ChangeNotifierProvider<AddressProvider>.value(value: AddressProvider()),
  ChangeNotifierProvider<RealTimeProvider>.value(value: RealTimeProvider()),
  ChangeNotifierProvider<UserRealTimeProvider>.value(
      value: UserRealTimeProvider()),
];
