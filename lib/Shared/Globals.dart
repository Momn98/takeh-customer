import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/main.dart';

screenMessage(
  String text, {
  Color color = Colors.black,
  Color textColor = Colors.white,
  double size = 16,
  ToastGravity gravity = ToastGravity.BOTTOM,
}) {
  return Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: gravity,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: textColor,
    fontSize: size,
  );
}

Widget globalText(
  String text, {
  TextStyle style = const TextStyle(),
  int? maxLines = null,
  TextOverflow? overflow = TextOverflow.ellipsis,
  TextAlign? textAlign = TextAlign.start,
  bool? softWrap,
  TextDirection? textDirection,
}) =>
    Text(
      text,
      style: style.copyWith(
        fontFamily: tabBarProvider.locale.languageCode == 'ar'
            ? Familys.Tajawal_Regular
            : Familys.futura_medium_bt,
      ),
      maxLines: maxLines,
      overflow: maxLines == null ? null : overflow,
      textAlign: textAlign,
      softWrap: softWrap,
      textDirection: textDirection,
    );

Widget globalButton(
  String text,
  Function()? function, {
  double radius = 8,
  Color? backColor,
  Color? borderColor,
  Color? textColor = Colors.white,
  FontWeight? fontWeight = FontWeight.normal,
  double? fontSize = 15,
  TextAlign? textAlign = TextAlign.center,
  Widget? icon,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center,
  double horizontal = 15,
  double vertical = 10,
}) =>
    InkWell(
      onTap: function,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(width: 1, color: borderColor ?? AppColor.orange),
          color: backColor ?? AppColor.orange,
        ),
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              icon,
              setWithSpace(20),
            ],
            globalText(
              text,
              textAlign: textAlign,
              style: TextStyle(
                color: textColor,
                fontWeight: fontWeight,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );

class GlobalSafeArea extends StatelessWidget {
  final Widget? body;
  final double horizontal;
  final double vertical;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;
  final bool extendBodyBehindAppBar;
  final bool showBackground;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const GlobalSafeArea({
    Key? key,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.appBar,
    this.resizeToAvoidBottomInset = true,
    this.extendBodyBehindAppBar = false,
    this.horizontal = 20,
    this.vertical = 20,
    this.floatingActionButtonLocation,
    this.showBackground = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: Colors.grey.shade100,
        appBar: appBar,
        body: SafeArea(
          child: Stack(
            children: [
              if (showBackground)
                Positioned.fill(
                  child: Image.asset(
                    GlobalImage.bg,
                    fit: BoxFit.fill,
                  ),
                ),
              Positioned.fill(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontal,
                    vertical: vertical,
                  ),
                  child: body!,
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: floatingActionButton,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
    );
  }
}

class NetworkImagePlace extends StatelessWidget {
  final String image;
  final double tl, tr, bl, br;
  final BoxFit fit;
  final double? all;

  const NetworkImagePlace({
    Key? key,
    required this.image,
    this.tl = 0,
    this.tr = 0,
    this.bl = 0,
    this.br = 0,
    this.fit = BoxFit.contain,
    this.all,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (image.length == 0) return CacheImagePlace();

    return CachedNetworkImage(
      imageUrl: image,
      fit: BoxFit.contain,
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      placeholder: (context, url) => CacheImagePlace(),
      errorWidget: (context, url, error) => CacheImagePlace(),
      imageBuilder: (context, image) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: all != null
                ? BorderRadius.circular(all!)
                : BorderRadius.only(
                    topLeft: Radius.circular(tl),
                    topRight: Radius.circular(tr),
                    bottomLeft: Radius.circular(bl),
                    bottomRight: Radius.circular(br),
                  ),
            image: DecorationImage(
              image: image,
              fit: fit,
            ),
          ),
        );
      },
    );
  }
}

class CacheImagePlace extends StatelessWidget {
  // the cach network image error and placeholder
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: LogoImage.logoNoBack,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
