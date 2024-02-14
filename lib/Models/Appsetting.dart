class Appsetting {
  int id = 0;
  String for_app = '';
  String contact_phone = '';
  String contact_email = '';
  String contact_whats_app = '';
  String web_site_link = '';
  String share_link = '';
  String facebook_link = '';
  String instagram_link = '';
  String snapchat_link = '';
  String tiktok_link = '';
  String twitter_link = '';
  String messenger_link = '';
  int app_version = 1;
  double latitude = 0.0;
  double longitude = 0.0;
  String location_link = '';

  Appsetting({
    this.id = 0,
    this.for_app = '',
    this.contact_phone = '',
    this.contact_email = '',
    this.contact_whats_app = '',
    this.web_site_link = '',
    this.share_link = '',
    this.facebook_link = '',
    this.instagram_link = '',
    this.snapchat_link = '',
    this.tiktok_link = '',
    this.twitter_link = '',
    this.messenger_link = '',
    this.app_version = 1,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.location_link = '',
  });

  Appsetting.fromAPI(Map data) {
    try {
      this.id = data['id'];
    } catch (e) {}
    try {
      this.for_app = data['for_app'];
    } catch (e) {}
    try {
      this.contact_phone = data['contact_phone'];
    } catch (e) {}
    try {
      this.contact_email = data['contact_email'];
    } catch (e) {}
    try {
      this.contact_whats_app = data['contact_whats_app'];
    } catch (e) {}
    try {
      this.web_site_link = data['web_site_link'];
    } catch (e) {}
    try {
      this.share_link = data['share_link'];
    } catch (e) {}
    try {
      this.facebook_link = data['facebook_link'];
    } catch (e) {}
    try {
      this.instagram_link = data['instagram_link'];
    } catch (e) {}
    try {
      this.snapchat_link = data['snapchat_link'];
    } catch (e) {}
    try {
      this.tiktok_link = data['tiktok_link'];
    } catch (e) {}
    try {
      this.twitter_link = data['twitter_link'];
    } catch (e) {}
    try {
      this.messenger_link = data['messenger_link'];
    } catch (e) {}
    try {
      this.app_version = data['app_version'];
    } catch (e) {}
    try {
      this.latitude = data['latitude'];
    } catch (e) {}
    try {
      this.longitude = data['longitude'];
    } catch (e) {}
    try {
      this.location_link = data['location_link'];
    } catch (e) {}
  }
}
