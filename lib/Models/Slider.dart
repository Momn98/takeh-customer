Future<List<Slider>> loopSliders(List data) async {
  List<Slider> _arr = [];
  for (var item in data) _arr.add(Slider.fromAPI(item));
  return _arr;
}

class Slider {
  int id = 0;
  // String slug = '';
  // String place = '';
  // String active_until = '';
  // String language = '';
  // String link = '';
  // String image = '';

  String image = '';
  String the_link = '';

  Slider({
    this.id = 0,
    // this.slug = '',
    // this.place = '',
    // this.active_until = '',
    // this.language = '',
    // this.link = '',
    // this.image = '',
    this.image = '',
    this.the_link = '',
  });

  Slider.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    // try {
    //   this.slug = data['slug'];
    // } catch (e) {}
    // try {
    //   this.place = data['place'];
    // } catch (e) {}
    // try {
    //   this.active_until = data['active_until'];
    // } catch (e) {}
    // try {
    //   this.language = data['language'];
    // } catch (e) {}
    // try {
    //   this.link = data['link'];
    // } catch (e) {}
    // try {
    //   this.image = data['thumbnail'];
    // } catch (e) {}

    try {
      this.image = data['image'];
    } catch (e) {}
    try {
      this.the_link = data['the_link'];
    } catch (e) {}
  }
}
