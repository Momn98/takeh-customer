Future<List<FirebaseNotification>> loopFirebaseNotifications(List data) async {
  List<FirebaseNotification> _arr = [];
  for (var item in data) _arr.add(FirebaseNotification.fromAPI(item));
  return _arr;
}

class FirebaseNotification {
  int id = 0;
  String title = '';
  String body = '';
  // String image = '';
  String the_page = '';
  int data_id = 0;
  bool seen = false;
  String seen_at = '';

  String date = '';
  String time = '';
  String created_at = '';
  String created_ago = '';

  FirebaseNotification({
    this.id = 0,
    this.title = '',
    this.body = '',
    // this.image = '',
    this.the_page = '',
    this.data_id = 0,
    this.seen = false,
    this.seen_at = '',
    this.date = '',
    this.time = '',
    this.created_at = '',
    this.created_ago = '',
  });

  FirebaseNotification.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.title = data['title'];
    } catch (e) {}
    try {
      this.body = data['body'];
    } catch (e) {}
    // try {
    //   this.image = data['image'];
    // } catch (e) {}
    try {
      this.the_page = data['the_page'];
    } catch (e) {}
    try {
      this.data_id = data['data_id'];
    } catch (e) {}
    try {
      this.seen = data['seen'];
    } catch (e) {}
    try {
      this.seen_at = data['seen_at'];
    } catch (e) {}

    try {
      this.date = data['date'];
    } catch (e) {}
    try {
      this.time = data['time'];
    } catch (e) {}
    try {
      this.created_at = data['created_at'];
    } catch (e) {}
    try {
      this.created_ago = data['created_ago'];
    } catch (e) {}
  }
}
