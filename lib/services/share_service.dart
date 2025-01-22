import 'dart:io';

import 'package:share_plus/share_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareService {
  static Future<void> shareApp() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String appLink =
        'https://play.google.com/store/apps/details?id=${packageInfo.packageName}';

    await Share.share(
      'Check out Ladder Up! An amazing productivity app that helps you achieve your goals.\n\n$appLink',
      subject: 'Ladder Up - Your Personal Goal Tracker',
    );
  }

  static Future<void> launchStoreForRating() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final Uri url;

    if (Platform.isAndroid) {
      url = Uri.parse('market://details?id=${packageInfo.packageName}');
    } else if (Platform.isIOS) {
      url = Uri.parse('https://apps.apple.com/app/idYOUR_APP_ID');
    } else {
      return;
    }

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> launchPrivacyPolicy() async {
    final Uri url = Uri.parse('https://pickme.lk/privacy-policy');
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.platformDefault,
      );
    }
  }
}
