Future<List<Applang>> loopApplangs(List data) async {
  List<Applang> _arr = [];
  for (var item in data) _arr.add(Applang.fromAPI(item));
  return _arr;
}

class Applang {
  int id = 0;
  String name = '';
  String code = '';
  String flag = '';

  Applang({
    this.id = 0,
    this.name = '',
    this.code = '',
    this.flag = '',
  });

  Applang.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.name = data['name'];
    } catch (e) {}
    try {
      this.code = data['code'];
    } catch (e) {}
    try {
      this.flag = data['flag'];
    } catch (e) {}
  }
}
