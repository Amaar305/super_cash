///
String formatDateTime(DateTime dateTime) {
  final dayPrefix =
      '${_getMonthName(dateTime.month)} ${dateTime.day}, ${dateTime.year}';

  // Format time in 12-hour format with AM/PM
  final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
  final minute = dateTime.minute.toString().padLeft(2, '0');
  final period = dateTime.hour < 12 ? 'am' : 'pm';
  final timeString = '$hour:$minute $period';

  return '$dayPrefix, $timeString';
}

String _getMonthName(int month) {
  const monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return monthNames[month - 1];
}

///
String dateAgo(DateTime createdAt) {
  final now = DateTime.now();
  final difference = now.difference(createdAt);
  if (difference.inDays > 0) {
    return '${difference.inDays}d ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours}h ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes}m ago';
  } else {
    return 'just now';
  }
}
