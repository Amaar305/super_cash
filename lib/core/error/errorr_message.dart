String extractErrorMessage(Map<String, dynamic> res) {
  if (res.containsKey('message') && res['message'] is String) {
    return res['message'];
  }
  if (res.containsKey('non_field_errors')) {
    final error = res['non_field_errors'];
    if (error is String) return error;
    if (error is List && error.isNotEmpty) return error[0];
  }

  if (res.containsKey('detail') && res['detail'] is String) {
    return res['detail'];
  }
  if (res.containsKey('phone') &&
      res['phone'] is List &&
      res['phone'].isNotEmpty) {
    if (res['phone'][0] is String) return res['phone'][0];
    if (res['phone'][0] is Map && res['phone'][0].containsKey('message')) {
      return res['phone'][0]['message'] as String;
    }
    if (res['phone'][0] is String) return res['phone'][0];
  }

  if (res['status'] == 'fail' && res.containsKey('message')) {
    final message = res['message'];
    if (message is String) return message;
    if (message is List && message.isNotEmpty) return message[0];
  }
  if (res['status'] is List &&
      res['status'].isNotEmpty &&
      res['status'][0] == 'fail' &&
      res.containsKey('message')) {
    final message = res['message'];
    if (message is String) return message;
    if (message is List && message.isNotEmpty) return message[0];
  }

  return 'Something went wrong. Try again later.';
}
