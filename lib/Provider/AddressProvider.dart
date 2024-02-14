import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takeh_customer/Api/AddressApi.dart';
import 'package:takeh_customer/Models/Address.dart';
import 'package:takeh_customer/Shared/SharedManaged.dart';

class AddressProvider extends ChangeNotifier {
  start() async {
    await getAllAddress();
    return;
  }

  AddressApi _api = AddressApi();

  int _selectedId = 0;

  List<Address> _address = [];
  List<Address> get address => _address;
  set address(List<Address> address) {
    _address = address;
  }

  Address _selectedAddress = Address();
  Address get selectedAddress => _selectedAddress;
  set selectedAddress(Address selectedAddress) {
    _selectedAddress = selectedAddress;
  }

  getAllAddress() async {
    this._address = await _api.getAllAddress();

    SharedPreferences pref = await SharedPreferences.getInstance();
    this._selectedId = pref.getInt(SharedKeys.selectedAddressId) ?? 0;
    for (Address item in this._address)
      if (this._selectedId == item.id) this._selectedAddress = item;
    notifyListeners();
  }

  Future<bool> saveAddress(Map data) async {
    Address address = await _api.saveAddress(data);
    if (address.id == 0) return false;
    this._address.add(address);
    notifyListeners();
    return true;
  }

  //
  setSelectedAddress(Address address) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(SharedKeys.selectedAddressId, address.id);
    this._selectedAddress = address;
    notifyListeners();
  }

  //
  Future delete(Address address) async {
    bool isDeleted = await _api.deleteAddress(address.id);
    if (!isDeleted) return;
    if (this.selectedAddress.id == address.id) _removeSelectedAddress();
    this._address.removeWhere((element) => element.id == address.id);
    notifyListeners();
  }

  _removeSelectedAddress() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt(SharedKeys.selectedAddressId, 0);
    this._selectedAddress = Address();
    notifyListeners();
  }
}
