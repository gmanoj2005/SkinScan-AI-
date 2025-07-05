import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class Update {


  Future<int> updateUserData(String result,String uid) async {
    try {
      print(uid);
      CollectionReference users = FirebaseFirestore.instance.collection(
          '/Users');
      DateTime now = DateTime.now();
      String formattedDateTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
      // Update user data
      await users.doc(uid).update({
        formattedDateTime:result
      });
    } catch (e) {
      print('Error updating user data: $e');
    }
    return 1;
  }

}
