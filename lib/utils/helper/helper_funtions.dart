import 'package:unite/utils/helper/firebase_helper.dart';

class UHelpers {
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );
    return emailRegex.hasMatch(email);
  }

  static Future<String> fetchUserName({required String id}) async {
    final user1 = await FireHelpers.usersRef.doc(id).get();
    String name = user1.get('name');
    return name;
  }

  static String sortString(String text) {
    // Convert the string to a list of characters
    List<String> characters = text.split('');

    // Sort the list of characters
    characters.sort();

    // Convert the sorted list back to a string
    String sortedString = characters.join('');

    return sortedString;
  }
}
