import 'package:takeh_customer/Models/Order.dart';
import 'package:takeh_customer/Pages/Orders/CreateOrderMultiStepOne.dart';
import 'package:takeh_customer/Pages/Home/Components/HomeSlider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:takeh_customer/Pages/Orders/CreateOrderPage.dart';
import 'package:takeh_customer/Pages/Orders/OneOrderPage.dart';
import 'package:takeh_customer/Pages/Wallet/WalletCard.dart';
import 'package:takeh_customer/Provider/OrderProvider.dart';
import 'package:takeh_customer/Provider/HomeProvider.dart';
import 'package:takeh_customer/Global/HomeAppBar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Models/Category.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:takeh_customer/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var orderProvider = OrderProvider();
  // final int initialPage = 0;
  int _currentIndex = 0;
  void callbackFunction(int index, CarouselPageChangedReason reason) {
    if (!mounted) return;
    setState(() => _currentIndex = index);
  }

  @override
  void initState() {
    authProvider.getWallet();

    orderProvider.getNorRatedOrder(context);
    // orderProvider.getDistance(10, 12, 13, 15);

    orderProvider.changePageStatus('active');
    super.initState();
  }

  @override
  void dispose() {
    locationProvider.controller = Completer();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalSafeArea(
      showBackground: true,
      appBar: HomeAppBar(
        preferredSize: Size.fromHeight(0),
        color: Colors.transparent,
        elevation: 0,
      ),
      vertical: 0,
      horizontal: 0,
      body: RefreshIndicator(
        onRefresh: () async {
          authProvider.getUser(context, moveAfterDone: false);
          await homeProvider.start();
          setState(() {});
          return;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      offset: Offset(0, 3),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: WalletCard(),
              ),
              Consumer<HomeProvider>(
                builder: (_, v, __) {
                  if (v.sliders.length == 0) return Container();
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 150,
                            viewportFraction: 1,
                            autoPlay: true,
                            enlargeCenterPage: true,
                            onPageChanged: callbackFunction,
                            // pageSnapping: false,
                          ),
                          items: v.sliders
                              .map((i) => HomeSingleSlider(i))
                              .toList(),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: AnimatedSmoothIndicator(
                              effect: ExpandingDotsEffect(
                                dotHeight: 7,
                                dotWidth: 7,
                                expansionFactor: 1.1,
                                activeDotColor: AppColor.orange,
                                dotColor: AppColor.secondary,
                              ),
                              activeIndex: _currentIndex,
                              count: v.sliders.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              setHeightSpace(10),
              Consumer<OrderProvider>(
                builder: (_, v, __) {
                  if (v.orders.length == 0) {
                    return Container();
                  }

                  Order order = v.orders.first;
                  if ([1, 2, 3, 7, 8 /*4, 5, 6*/].contains(v.order.status.id)) {
                    return Container();
                  }

                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        if (v.orders.length > 1)
                          Row(
                            children: [
                              globalText(S.current.orders),
                              Spacer(),
                              globalText(v.orders.length.toStringAsFixed(0)),
                            ],
                          ),
                        Card(
                          child: InkWell(
                            onTap: () async {
                              v.order = order;
                              await NavMove.goToPage(context, OneOrderPage());

                              authProvider.getWallet();
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: globalText(
                                          '${S.current.orderID} ${order.slug}',
                                        ),
                                      ),
                                      globalText(
                                        order.status.name,
                                        style: TextStyle(
                                          color: order.status.color,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Divider(),
                                  globalText(
                                      '${S.current.service}: ${order.category.name}'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              setHeightSpace(10),
              Consumer<HomeProvider>(
                builder: (_, v, __) {
                  if (v.categorys.length == 0) {
                    return Column(
                      children: [
                        setHeightSpace(20),
                        CircularProgressIndicator(),
                      ],
                    );
                  }

                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: v.categorys.length,
                    itemBuilder: (context, index) {
                      Category category = v.categorys[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 1,
                        child: InkWell(
                          onTap: () async {
                            orderProvider.category = category;

                            if (category.slug.contains("multi-step-order")) {
                              await NavMove.goToPage(
                                  context, CreateOrderMultiStepOne());
                            } else {
                              await NavMove.goToPage(
                                  context, CreateOrderPage());
                            }

                            orderProvider.orders = [];

                            authProvider.getWallet();
                            orderProvider.changePageStatus('active');
                          },
                          child: Container(
                            padding: EdgeInsets.all(6),
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: NetworkImagePlace(
                                    image: category.image,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                setHeightSpace(3),
                                Expanded(
                                  child: globalText(
                                    category.name,
                                    maxLines: 2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
