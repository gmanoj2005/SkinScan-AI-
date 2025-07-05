//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:skinscan_ai/features/toast.dart';



class FirebaseAuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _store= FirebaseFirestore.instance;
  Future<User?> signUpWithEmailAndPassword(String firstname,String lastname,String phonenumber,String email, String password) async {

    try {
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
     // var collection = FirebaseFirestore.instance.collection('User');
     // collection
       //   .doc(email) // <-- Document ID
         // .set({'FirstName':firstname,'LastName':lastname,'PhoneNumber':phonenumber,'Email':email,'password':password}) // <-- Your data
          //.then((_) => print('Added'))
          //.catchError((error) => print('Add failed: $error'));

      String uid = credential.user?.uid ?? 'No UID found';
      DocumentReference<Map<String, dynamic>> users = FirebaseFirestore
          .instance
          .collection('/Users')
          .doc(uid);
      var myJSONObj = {'FirstName':firstname,'LastName':lastname,'PhoneNumber':phonenumber,'Email':email};
      users
          .set(myJSONObj)
          .then((value) => print("User with CustomID added"))
          .catchError((error) => print("Failed to add user: $error"));
     // await _store.collection('Users').add({'FirstName':firstname,'LastName':lastname,'PhoneNumber':phonenumber,'Email':email,'password':password});
      return credential.user;
    } on FirebaseAuthException catch (e) {

      if (e.code == 'email-already-in-use') {
        showToastMsg(message: 'The email address is already in use.');
      } else {
        showToastMsg(message: 'An error occurred: ${e.code}');
      }
    }
    on Exception catch(e){
      showToastMsg(message: 'An error occurred: ${e}');
    }
    return null;

  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToastMsg(message: 'email not found or wrong password');
      } else {
        showToastMsg(message: 'An error occurred: ${e.code}');
      }

    }
    return null;

  }



}

