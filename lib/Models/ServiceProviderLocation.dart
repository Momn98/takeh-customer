Future<List<ServiceProviderLocation>> loopServiceProviderLocations(
    List data) async {
  List<ServiceProviderLocation> _arr = [];
  for (var item in data) _arr.add(ServiceProviderLocation.fromAPI(item));
  return _arr;
}

class ServiceProviderLocation {
  int id = 0;
  double latitude = 0.0;
  double longitude = 0.0;
  String status = '';

  ServiceProviderLocation({
    this.id = 0,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.status = '',
  });

  ServiceProviderLocation.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.latitude = data['latitude'];
    } catch (e) {}
    try {
      this.longitude = data['longitude'];
    } catch (e) {}
    try {
      this.status = data['status'];
    } catch (e) {}
  }
}
