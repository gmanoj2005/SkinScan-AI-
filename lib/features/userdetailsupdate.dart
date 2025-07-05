import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skinscan_ai/features/mlresult.dart';
class Update {


  Future<int> updateUserData(String firstname, String lastname,
      String phonenumber, String email, String password,String uid) async {
    try {
      // Reference to the Firestore collection 'users' and document with the given userId
      CollectionReference users = FirebaseFirestore.instance.collection(
          '/Users');

      // Update user data
      await users.doc(uid).update({
        'FirstName': firstname,
        'LastName': lastname,
        'PhoneNumber': phonenumber,
        'Email': email,
        'Password': password
      });


      print('User data updated successfully!');
    } catch (e) {
      print('Error updating user data: $e');
    }
    return 1;
  }

}