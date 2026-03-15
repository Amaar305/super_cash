import 'package:shared/shared.dart';
import 'package:url_launcher/url_launcher.dart';

void launchLink(String url, {LaunchMode? browserMode}) {
  try {
    final websiteUrl = Uri.parse(url);

    launchUrl(websiteUrl, mode: browserMode ?? LaunchMode.inAppBrowserView);
  } catch (e, s) {
    // showErrorToast('Browser cannot be open.');
    logE("Failed to lauch url, $e", stackTrace: s);
  }
}

void dialNumber(String number) {
  try {
    _makePhoneCall(number);
  } catch (e, s) {
    logE('Failed to dial number, $e', stackTrace: s);
  }
}

Future<void> _makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    logE("Could not launch $launchUri");
  }
}
