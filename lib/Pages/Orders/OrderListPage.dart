import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeh_customer/Global/HomeAppBar.dart';
import 'package:takeh_customer/Models/Order.dart';
import 'package:takeh_customer/Pages/Orders/OneOrderPage.dart';
import 'package:takeh_customer/Provider/OrderProvider.dart';
import 'package:takeh_customer/Shared/Constant.dart';
import 'package:takeh_customer/Shared/Globals.dart';
import 'package:takeh_customer/Shared/NavMove.dart';
import 'package:takeh_customer/Shared/i18n.dart';
import 'package:takeh_customer/main.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  String status = 'all';
  ScrollController _sc = ScrollController();

  int _expandedOrderIndex = -1;

  @override
  void initState() {
    orderProvider.status = status;
    orderProvider.changePageStatus(status);

    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent)
        orderProvider.getOrders();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GlobalSafeArea(
      horizontal: 10,
      vertical: 0,
      appBar: HomeAppBar(text: S.current.myOrders),
      body: Consumer<OrderProvider>(
        builder: (_, v, __) {
          return RefreshIndicator(
            onRefresh: () async {
              await orderProvider.changePageStatus(status);

              return;
            },
            child: Column(
              children: [
                if (v.orders.length == 0) ...[
                  setHeightSpace(50),
                  if (v.haveMoreOrders)
                    Center(child: CircularProgressIndicator())
                  else
                    Center(child: Text(S.current.noOrders)),
                ],
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      controller: _sc,
                      itemCount: v.orders.length,
                      itemBuilder: (context, index) {
                        Order order = v.orders[index];

                        bool isExpanded = _expandedOrderIndex == index;
                        return Card(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (!isExpanded) {
                                          setState(() {
                                            _expandedOrderIndex = index;
                                          });
                                        } else {
                                          setState(() {
                                            _expandedOrderIndex = -1;
                                          });
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                                '${S.current.orderID} ${order.slug}'),
                                          ),
                                          Text(
                                            order.status.name,
                                            style: TextStyle(
                                                color: order.status.color),
                                          ),
                                          IconButton(
                                            icon: Icon(isExpanded
                                                ? Icons.expand_less
                                                : Icons.expand_more),
                                            onPressed: () {
                                              if (!isExpanded) {
                                                setState(() {
                                                  _expandedOrderIndex = index;
                                                });
                                              } else {
                                                _expandedOrderIndex = -1;
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (isExpanded) ...[
                                      Divider(),
                                      InkWell(
                                        onTap: () {
                                          v.order = order;
                                          NavMove.goToPage(
                                              context, OneOrderPage());
                                        },
                                        child: Container(
                                          width: double.infinity,
                                          padding:
                                              EdgeInsets.symmetric(vertical: 5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${S.current.discountedAmount}: ${order.discounted_amount.toStringAsFixed(2)}',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              Text(
                                                '${S.current.paidCash}: ${order.paid_cash.toStringAsFixed(2)}',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              Text(
                                                '${S.current.paidWallet}: ${order.paid_wallet.toStringAsFixed(2)}',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
