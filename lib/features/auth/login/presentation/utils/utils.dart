String maskEmail(String email) {
  final parts = email.split('@');
  if (parts.length != 2) return email; // invalid email

  final username = parts[0];
  final domain = parts[1];

  // Show the first 5 characters of the username, or less if shorter
  final visiblePart =
      username.length <= 5 ? username : username.substring(0, 5);

  return '($visiblePart*****$domain)';
}
