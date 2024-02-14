Future<List<DriverLocation>> loopDriverLocation(List data) async {
  List<DriverLocation> _arr = [];
  for (var item in data) _arr.add(DriverLocation.fromAPI(item));
  return _arr;
}

class DriverLocation {
  int id = 0;
  double lat = 0.0;
  double long = 0.0;
  String status = '';

  DriverLocation({
    this.id = 0,
    this.lat = 0.0,
    this.long = 0.0,
    this.status = '',
  });

  DriverLocation.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.lat = data['latitude'] + 0.0;
    } catch (e) {}
    try {
      this.long = data['longitude'] + 0.0;
    } catch (e) {}
    try {
      this.status = data['status'];
    } catch (e) {}
  }
}
