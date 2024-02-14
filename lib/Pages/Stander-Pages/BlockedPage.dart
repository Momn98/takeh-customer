import 'package:flutter/material.dart';
import 'package:takeh_customer/Global/HomeAppBar.dart';
import 'package:takeh_customer/Global/SocialMedia.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/i18n.dart';

class BlockedPage extends StatelessWidget {
  const BlockedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalSafeArea(
      appBar: HomeAppBar(
        preferredSize: Size.fromHeight(75),
        color: Colors.transparent,
        elevation: 0,
        text: S.current.sorryYourAccountBlocked,
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GlobalImage.unlock,
          ),
          setHeightSpace(30),
          globalText(
            S.current.pleaseContactUsToRemoveBlock,
            style: TextStyle(fontSize: 17),
          ),
          setHeightSpace(20),
          // globalText(
          //   S.current.or,
          //   style: TextStyle(fontSize: 17),
          // ),
          // setHeightSpace(20),
          // globalButton(
          //   S.current.signOut,
          //   () => authProvider.logOut(context),
          // ),
          SocialMedia(),
          setHeightSpace(20),
        ],
      ),
    );
  }
}
