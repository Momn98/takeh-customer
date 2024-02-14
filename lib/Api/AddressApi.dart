import 'package:takeh_customer/Api/Api_util.dart';
import 'package:takeh_customer/Models/Address.dart';
import 'package:takeh_customer/Models/ApiData.dart';

class AddressApi {
  // Future<List<Address>> getAddresss(int page, {String? status}) async {
  //   List<Address> address = [];
  //   String url = ApiUtil.Address;
  //   if (status != null) url += '?status=$status';

  //   ApiData response = await theGet(url);
  //   // if (response.statusCode == 200) address = await loopAddresss(response.data);

  //   return address;
  // }

  Future<List<Address>> getAllAddress() async {
    List<Address> address = [];
    String url = ApiUtil.Address;

    ApiData response = await theGet(url);
    if (response.statusCode == 200) address = await loopAddresss(response.data);

    return address;
  }

  Future<Address> saveAddress(Map data) async {
    Address address = Address();
    String url = ApiUtil.Address;
    ApiData response = await theSend(url, data);
    if (response.statusCode == 201) address = Address.fromAPI(response.data);
    return address;
  }

  Future<bool> deleteAddress(int id) async {
    String url = ApiUtil.Address + '/$id';
    ApiData response = await theDelete(url);
    if (response.statusCode == 201) return true;
    return false;
  }
}
