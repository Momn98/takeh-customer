Future<List<Appimage>> loopAppimages(List data) async {
  List<Appimage> _arr = [];
  for (var item in data) _arr.add(Appimage.fromAPI(item));
  return _arr;
}

class Appimage {
  int id = 0;
  String the_model_name = '';
  String the_model_id = '';
  String place = '';
  String image = '';

  Appimage({
    this.id = 0,
    this.the_model_name = '',
    this.the_model_id = '',
    this.place = '',
    this.image = '',
  });

  Appimage.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.the_model_name = data['the_model_name'];
    } catch (e) {}
    try {
      this.the_model_id = data['the_model_id'];
    } catch (e) {}
    try {
      this.place = data['place'];
    } catch (e) {}
    try {
      this.image = data['image'];
    } catch (e) {}
  }
}
