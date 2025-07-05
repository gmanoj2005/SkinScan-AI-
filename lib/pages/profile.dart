import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skinscan_ai/features/userdetailsupdate.dart';

import '../features/toast.dart';
import '../features/userauthentication.dart';
import 'editprofile.dart';
class Profile extends StatefulWidget{

  final  String docId;
  const Profile({Key? key, required this.docId}) : super(key: key);
  @override
  UserProfile  createState(){
    return UserProfile();
  }

}

class UserProfile extends State<Profile> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String ocId;
  String firstname="";
   String lastname="";
   String phonenumber="";
  String email="";

//  final FirebaseAuthService _auth = FirebaseAuthService();
  final formKey = GlobalKey<FormState>();
  bool notVisible = true;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Function to pick image from gallery or camera
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }


  void initState() {
    super.initState();
    ocId = widget.docId;
    fetchData();
    //  firstnamecontroller.text= firstname.isEmpty ? 'Loading...':firstname;
    // lastnamecontroller.text= lastname.isEmpty ? 'Loading...':lastname;
    //phonenumbercontroller.text= phonenumber.isEmpty ? 'Loading...':phonenumber;
    //  emailcontroller.text= email.isEmpty ? 'Loading...':email;
    // passwordcontroller.text= password.isEmpty ? 'Loading...':password;
  }
/*
  Future<void> _updateUserData() async {
    if (formKey.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // Update email
          await user.updateEmail(emailcontroller.text);
          await user.reload();
          user = FirebaseAuth.instance.currentUser; // Refresh user
          // Update password (optional, if provided)
          if (passwordcontroller.text.isNotEmpty) {
            await user?.updatePassword(passwordcontroller.text);
          }
        }
        //widget.docId=emailcontroller.text;
         await FirebaseFirestore.instance.collection('Users')
            .doc(ocId)
            .set({
          'FirstName': firstnamecontroller.text,
          'LastName': lastnamecontroller.text,
          'PhoneNumber': phonenumbercontroller.text,
          'Email': emailcontroller.text,
          'Password': passwordcontroller.text
        },SetOptions(merge: true));
      //  await FirebaseFirestore.instance.collection('Users').doc(emailcontroller.text).set(ocId as Map<String, dynamic>);


        // Optionally delete the old document
       // await FirebaseFirestore.instance.collection('Users').doc(ocId).delete();
        ocId=emailcontroller.text;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User data updated successfully!')),
        );
      } catch (e) {
        print('Error updating user data: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update user data')),
        );
      }
    }
  }

  Future<void> updateimage()async {
    DocumentReference<Map<String, dynamic>> users = FirebaseFirestore
        .instance
        .collection('/Users')
        .doc(email);
    var myJSONObj = {'ProfileImage':_imageFile};
    users.set(myJSONObj)
        .then((value) => print("User with CustomID added"))
        .catchError((error) => print("Failed to add user: $error"));


  }
*/
    Future<void> fetchData() async {
      try {
        // Fetch a document from a Firestore collection
        DocumentSnapshot snapshot = await _firestore.collection('Users').doc(ocId).get();
        if (snapshot.exists) {
          setState(() {
            firstname= snapshot['FirstName'];
            lastname = snapshot['LastName'];
            phonenumber = snapshot['PhoneNumber'];
            email = snapshot['Email'];
            // Assuming 'name' is a field in the document
          });
        } else {
          setState(() {
            //_data = 'Document not found!';
          });
        }
      } catch (e) {
        setState(() {
          // _data = 'Error: $e';
        });
      }
    }

    @override
    Widget build(BuildContext context) {


      //documentId=data?['email'];

      //DocumentSnapshot? docsnap;
      //data= ModalRoute.of(context)?.settings.arguments as Map?;
      // print(data);

      //  final snapshot=db.collection('Users').where('Email',isEqualTo:data?['email']).get();
      //final userdata=snapshot.
      //  print(snapshot.data!.docs[''] );
//print(dta);
      //  print(documentData);
      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
              "Profile",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.w300)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey[300],
                backgroundImage: _imageFile != null
                    ? FileImage(
                    _imageFile!) // Display selected image
                    : AssetImage('assets/default_profile.png') as ImageProvider, // Default image if none selected
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  textAlign: TextAlign.left,
                  "First Name",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      firstname,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Last Name",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      lastname,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Phone Number",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      phonenumber,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    SizedBox(width: 10),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(height: 20),
              Container(
                child: ElevatedButton.icon(
                    icon: Icon(Icons.edit, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60),
                        backgroundColor:  Color(0xFF0F52BA),
                        shape: RoundedRectangleBorder( //to set border radius to button
                            borderRadius: BorderRadius.circular(50)
                        )),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfile(docId: ocId,)),
                      );
                    },
                    label: Text("Edit Profile", style: TextStyle(
                        color: Colors.white, fontSize: 25),)),
              ),
              SizedBox(height: 8),
              Container(
                child: ElevatedButton.icon(
                    icon: Icon(Icons.lock_reset_sharp, color: Colors.white),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60),
                        backgroundColor:  Color(0xFF0F52BA),
                        shape: RoundedRectangleBorder( //to set border radius to button
                            borderRadius: BorderRadius.circular(50)
                        )),
                    onPressed: () {
                      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                      showToastMsg(message: 'Password reset request is Sent to your mail');
                    },
                    label: Text("Reset Password", style: TextStyle(
                        color: Colors.white, fontSize: 25),)),
              ),
            ],
          ),
        ),
      );
    }


  }




