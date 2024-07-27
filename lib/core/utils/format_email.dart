String formatEmail(String email, bool displayFullEmail) {
  if (displayFullEmail) {
    return email; // Return full email
  } else {
    final parts = email.split('@');
    final localPart = parts[0];
    final domainPart = parts[1];
    final maskedLocalPart = localPart.substring(0, 3) + '*' * (localPart.length - 3);
    return '$maskedLocalPart@$domainPart';
  }
}