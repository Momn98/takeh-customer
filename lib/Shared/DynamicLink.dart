import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:takeh_customer/main.dart';

class MyDynamicLink {
  String link = tabBarProvider.setting.share_link;

  Future<Uri> createLink(
    String page,
    int id, {
    String? title,
    String? description,
    String? imageLink,
  }) async {
    DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: link,
      link: Uri.parse(link + '/$page?id=$id'),
      androidParameters: AndroidParameters(packageName: 'com.takeh.customer'),
      iosParameters: IOSParameters(bundleId: 'com.takeh.user'),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: title,
        description: description,
      ),
    );

    ShortDynamicLink dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);

    return dynamicLink.shortUrl;
  }
}
