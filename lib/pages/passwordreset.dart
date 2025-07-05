import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skinscan_ai/pages/passwordresetmailresend.dart';

import '../features/toast.dart';

class ResetPwPage extends StatefulWidget{
  @override
  PwReset createState() {
    return  PwReset();
  }
}
class PwReset extends State<ResetPwPage>{
  final formKey = GlobalKey<FormState>();
  TextEditingController emailcontroller=TextEditingController();

  @override
  void dispose() {
    emailcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

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
        child: Center(
          child: Container(
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Forget password",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Don't worry, sometimes people can forget too. Enter your email and we will send you a password reset link.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      style: TextStyle(fontSize: 20),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.name,
                      controller: emailcontroller,
                      validator: (String? value) {
                        RegExp emailRegex = RegExp(
                            r'^[a-zA-Z0-9]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
                        );


                        if (value!.isEmpty) {
                          return 'Enter Your Email';
                        } else {
                          if (!emailRegex.hasMatch(value!)) {
                            return 'Enter Valid Email';
                          } else {
                            return null;
                          }
                        }
                      },
                      decoration: InputDecoration(
                        // floatingLabelStyle: TextStyle(color:focusNode.hasFocus? Colors.blue:Colors.grey[600]),
                        //labelStyle: TextStyle(fontSize: 20, color: Colors.green),
                        labelText: "Email",
                        labelStyle: TextStyle(fontSize: 20),
                        // fillColor: Colors.grey[200],
                        //focusColor: Colors.grey,
                        //  focusedBorder: OutlineInputBorder(
                        //  borderRadius: BorderRadius.circular(50),
                        //  borderSide: BorderSide(color: Colors.blue)),


                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.black),
                            borderRadius: BorderRadius.circular(50) ),

                        prefixIcon: IconButton(
                          color: Colors.black,
                          icon:Icon(Icons.mail),
                          onPressed: () {  },
                          // filled: true,

                        ),
                      ),
                    ),
                    SizedBox(height: 12,),

                    SizedBox(height: 30),
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

                            if(formKey.currentState!.validate()){
                              FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text);
                              showToastMsg(message: 'Password reset request is sent to your mail');
                              Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordResetResentPage(mail:emailcontroller.text)));
                            }
                          },
                          child: Text("Submit",style: TextStyle(color: Colors.white,fontSize:25),)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}