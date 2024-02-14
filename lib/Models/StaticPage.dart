Future<List<StaticPage>> loopStaticPages(List data) async {
  List<StaticPage> _arr = [];
  for (var item in data) _arr.add(StaticPage.fromAPI(item));
  return _arr;
}

class StaticPage {
  int id = 0;
  String page_link = '';
  String title = '';
  String desc = '';

  StaticPage({
    this.id = 0,
    this.page_link = '',
    this.title = '',
    this.desc = '',
  });

  StaticPage.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.page_link = data['page_link'];
    } catch (e) {}
    try {
      this.title = data['title'];
    } catch (e) {}
    try {
      this.desc = data['desc'];
    } catch (e) {}
  }
}
