class PromoCode {
  int id = 0;
  String slug = '';
  String code = '';
  double amount = 0.0;
  String type = '';
  int max_allowed_use_time = 0;
  int used_count = 0;
  String from_date = '';
  String to_date = '';
  bool is_active = false;

  PromoCode({
    this.id = 0,
    this.slug = '',
    this.code = '',
    this.amount = 0.0,
    this.type = '',
    this.max_allowed_use_time = 0,
    this.used_count = 0,
    this.from_date = '',
    this.to_date = '',
    this.is_active = false,
  });

  PromoCode.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.slug = data['slug'];
    } catch (e) {}
    try {
      this.code = data['code'];
    } catch (e) {}
    try {
      this.amount = data['amount'] + 0.0;
    } catch (e) {}
    try {
      this.type = data['type'];
    } catch (e) {}
    try {
      this.max_allowed_use_time = data['max_allowed_use_time'] + 0;
    } catch (e) {}
    try {
      this.used_count = data['used_count'] + 0;
    } catch (e) {}
    try {
      this.from_date = data['from_date'];
    } catch (e) {}
    try {
      this.to_date = data['to_date'];
    } catch (e) {}
    try {
      this.is_active = data['is_active'];
    } catch (e) {}
  }
}
