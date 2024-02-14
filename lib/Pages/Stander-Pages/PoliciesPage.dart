import 'package:takeh_customer/Provider/HomeProvider.dart';
import 'package:takeh_customer/Global/HomeAppBar.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:takeh_customer/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PoliciesPage extends StatefulWidget {
  final String page;
  const PoliciesPage({Key? key, required this.page}) : super(key: key);
  @override
  State<PoliciesPage> createState() => _PoliciesPageState();
}

class _PoliciesPageState extends State<PoliciesPage> {
  @override
  void initState() {
    homeProvider.getPoliciesApi(widget.page);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (_, v, __) {
        return GlobalSafeArea(
          appBar: HomeAppBar(text: v.staticPage.title),
          body: SingleChildScrollView(
            child: v.haveStaticPage
                ? Html(data: v.staticPage.desc)
                : Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
