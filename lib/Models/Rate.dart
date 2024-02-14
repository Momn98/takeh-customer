class Rate {
  int id = 0;
  double stars_count = 0.0;
  String rate_by = '';
  String text = '';
  // rate_on_user

  Rate({
    this.id = 0,
    this.stars_count = 0.0,
    this.rate_by = '',
    this.text = '',
  });

  Rate.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.stars_count = data['stars_count'];
    } catch (e) {}
    try {
      this.rate_by = data['rate_by'];
    } catch (e) {}
    try {
      this.text = data['text'];
    } catch (e) {}
  }
}
