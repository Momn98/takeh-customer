class Option {
  int id = 0;
  String slug = '';
  double price = 0.0;
  double extra_price = 0.0;
  String extra_after = '';
  String name = '';
  String desc = '';
  String image = '';

  Option({
    this.id = 0,
    this.slug = '',
    this.price = 0.0,
    this.extra_price = 0.0,
    this.extra_after = '',
    this.name = '',
    this.desc = '',
    this.image = '',
  });

  Option.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.slug = data['slug'];
    } catch (e) {}
    try {
      this.price = data['price'] + 0.0;
    } catch (e) {}
    try {
      this.extra_price = data['extra_price'] + 0.0;
    } catch (e) {}
    try {
      this.extra_after = data['extra_after'];
    } catch (e) {}
    try {
      this.name = data['name'];
    } catch (e) {}
    try {
      this.desc = data['desc'];
    } catch (e) {}
    try {
      this.image = data['image'];
    } catch (e) {}
  }
}
