import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skinscan_ai/pages/passwordreset.dart';

import '../features/toast.dart';

class PasswordResetResentPage extends StatefulWidget {
  final  String mail;
  const PasswordResetResentPage({Key? key, required this.mail}) : super(key: key);

  @override
  _PasswordResetSentPageState createState() => _PasswordResetSentPageState();
}

class _PasswordResetSentPageState extends State<PasswordResetResentPage> {
   // Replace with dynamic data if needed

  @override
  Widget build(BuildContext context) {
    String email = widget.mail;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () {
              Navigator.pop(context); // Close the page
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            // Illustration (Replace with your own asset)
            Center(
              child: Image.asset(
               "assets/mailsent.png",// Replace with your image URL or asset
                height: 150,
              ),
            ),
            SizedBox(height: 30),
            Text(
              "Password Reset Email Sent",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "Your Account Security is Our Priority! We've sent you a secure link to safely change your password and keep your account protected.",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            Container(
              height: 60,
              child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(60),
                      backgroundColor:  Color(0xFF0F52BA),
                      shape: RoundedRectangleBorder( //to set border radius to button
                          borderRadius: BorderRadius.circular(50)
                      )),
                  onPressed: (){
                    Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
                  },
                  child: Text("Done",style: TextStyle(color: Colors.white,fontSize:25),)),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                showToastMsg(message: 'Password reset request is re-sent to your mail');
              },
              child: Text(
                "Resend Email",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

