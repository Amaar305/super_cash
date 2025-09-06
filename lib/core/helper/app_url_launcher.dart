import 'package:shared/shared.dart';
import 'package:url_launcher/url_launcher.dart';


void launchLink(String url, {LaunchMode? browserMode}) {
  try {
    final websiteUrl = Uri.parse(url);

    launchUrl(
      websiteUrl,
      mode: browserMode ?? LaunchMode.inAppBrowserView,
    );
  } catch (e) {
    // showErrorToast('Browser cannot be open.');
    logE("Failed to lauch url");
  }
}
