import 'package:takeh_customer/Api/Api_util.dart';
import 'package:takeh_customer/Models/ApiData.dart';
import 'package:takeh_customer/Models/Order.dart';
import 'package:takeh_customer/Models/PromoCode.dart';
import 'package:takeh_customer/Models/Rate.dart';
import 'package:takeh_customer/Shared/Globals.dart';

class OrderApi {
  Future<Order> submitOrder(Map data) async {
    String url = ApiUtil.Submit_Order;
    ApiData response = await theSend(url, data);

    if (response.statusCode == 201)
      return Order.fromAPI(response.data['order']);

    return Order();
  }

  Future<List<Order>> getOrders(int page, String status) async {
    String url = ApiUtil.Orders + '?status=$status&page=$page';
    ApiData response = await theGet(url);

    if (response.statusCode == 200)
      return await loopOrders(response.data['orders']);

    return [];
  }

  Future<Order?> changeOrder(Map data) async {
    String url = ApiUtil.Change_Order;
    ApiData response = await theSend(url, data);

    if (response.statusCode == 201)
      return Order.fromAPI(response.data['order']);
    return null;
  }

  Future<Rate?> rateOrder(Map data) async {
    String url = ApiUtil.Rate_Order;
    ApiData response = await theSend(url, data);
    if (response.statusCode == 200) return Rate.fromAPI(response.data['rate']);
    return null;
  }

  //

  Future<PromoCode> checkPromoCode(String code, int id) async {
    String _endUrl =
        ApiUtil.PromoCodeCheck + '?category_id=$id&promo_code=$code';
    PromoCode promoCode = PromoCode();

    ApiData response = await theGet(_endUrl);

    if (response.statusCode == 200)
      promoCode = PromoCode.fromAPI(response.data['promo_code']);

    if (response.showMessage) screenMessage(response.message);

    return promoCode;
  }

  Future<Order?> getNorRatedOrder() async {
    String url = ApiUtil.Not_Rated_Order;
    ApiData response = await theGet(url);

    if (response.statusCode == 200)
      return await Order.fromAPI(response.data['order']);
    return null;
  }
}
