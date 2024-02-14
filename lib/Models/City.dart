Future<List<City>> loopCitys(List data) async {
  List<City> _arr = [];
  for (var item in data) _arr.add(City.fromAPI(item));
  return _arr;
}

class City {
  int id = 0;
  String name = '';

  City({
    this.id = 0,
    this.name = '',
  });

  City.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.name = data['name'];
    } catch (e) {}
  }
}
