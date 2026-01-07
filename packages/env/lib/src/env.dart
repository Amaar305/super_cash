// ignore_for_file: public_member_api_docs

enum Env {
  appStoreUrl('APP_STORE_URL'),
  playStoreUrl('PLAY_STORE_URL'),
  appBaseUrl('APP_BASE_URL');

  const Env(this.value);

  final String value;
}
