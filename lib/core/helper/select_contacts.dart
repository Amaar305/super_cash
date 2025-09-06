import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

/// Function to pick a contact
/// Returns a [Contact] if one is selected, or `null` if no contact is selected.
Future<String?> pickContact(BuildContext context) async {
  // Request contacts permission
  final permissionStatus = await Permission.contacts.request();
  if (!context.mounted) return null;

  if (!permissionStatus.isGranted) {
    // Show a message if permission is denied
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Contacts permission is denied")),
    );
    return null;
  }

  try {
    // Fetch contacts
    var contact = await FlutterContacts.openExternalPick();

    // // Use synchronous navigation to avoid async gap issues
    // return await Navigator.of(context).push<Contact?>(
    //   MaterialPageRoute(
    //     builder: (_) => _ContactListPage(contacts: contacts),
    //   ),
    // );

    if (contact != null && contact.phones.isNotEmpty) {
      final nonDigit = RegExp("\\D");
      String phoneNumber = contact.phones.first.number;
      phoneNumber = phoneNumber.replaceAll(nonDigit, "");
      phoneNumber = phoneNumber.replaceFirst("234", "0");
      phoneNumber = phoneNumber.replaceFirst("+234", "0");
      return phoneNumber;
    }
    return null;
  } catch (e) {
    // Handle errors
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to pick contact: $e")),
      );
    }
    return null;
  }
}
