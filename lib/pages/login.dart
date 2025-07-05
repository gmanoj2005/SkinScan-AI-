
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skinscan_ai/pages/passwordreset.dart';
import 'package:skinscan_ai/pages/signup.dart';

import '../features/toast.dart';
import '../features/userauthentication.dart';
import 'home.dart';
import 'intro.dart';
class Login extends StatefulWidget{
  @override
  UserLogin  createState(){
    return UserLogin();
  }

}

class UserLogin extends State<Login>{
  TextEditingController emailcontroller=TextEditingController();
  bool _isScaled = false;
  TextEditingController passwordcontroller=TextEditingController();
  bool notVisible=true;
  bool isSigning = true;
  Color color=Colors.blue;
  FocusNode focusNode = FocusNode();
  bool elabel=true;
  final formKey = GlobalKey<FormState>();
  final FirebaseAuthService _auth = FirebaseAuthService();
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: Colors.white,),
      backgroundColor: Colors.white,
      body:Center(
        child:Container(
          margin: EdgeInsets.fromLTRB(25,0,25,25),
          child:Center(
    child: Form(
                key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                   Text("Login",style: TextStyle(fontSize: 50),textAlign: TextAlign.center),
                    SizedBox(height: 20,),
                    //Text("Email                                                                ",style: TextStyle(fontSize: 22),textAlign: TextAlign.left,),
                   // SizedBox(height: 5,),
                
                    TextFormField(
                      style: TextStyle(fontSize:20),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.emailAddress,
                      controller:emailcontroller ,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                         setState(() {
                           elabel=false;
                         });
                          return 'Enter Your Email';
                        }
                          else {
                          setState(() {
                            elabel=true;
                          });
                          return null;
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
                    //Text("Password                                                                ",style: TextStyle(fontSize: 22),textAlign: TextAlign.left,),
                    //SizedBox(height: 5,),
                
                    TextFormField(
                      style: TextStyle(fontSize:20),
                      cursorColor: Colors.black,
                      obscureText: notVisible,
                      controller:passwordcontroller ,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter  Your Password';
                        }
                        else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                       // floatingLabelStyle: TextStyle(color:elabel? Colors.blue:Colors.red),
                        labelStyle: TextStyle(fontSize: 20),
                          labelText: "Password",
                        suffixIcon: IconButton(
                          color: Colors.black,
                            onPressed: (){
                              setState(() {
                                notVisible=!notVisible;
                              });
                            },
                            icon:notVisible?Icon(Icons.visibility_off):Icon(Icons.visibility)),
                        //fillColor: Colors.grey[200],
                       // focusedBorder: OutlineInputBorder(
                        //    borderRadius: BorderRadius.circular(50),
                         //   borderSide: BorderSide(color: Colors.blue)),
                        border: OutlineInputBorder( borderRadius: BorderRadius.circular(50) ),
                        prefixIcon: IconButton(
                          color: Colors.black,
                          icon:Icon(Icons.security_rounded),
                          onPressed: () {  },
                        //filled: true,
                
                      ),
                    ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding:  EdgeInsets.only(left:198),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ResetPwPage()));
                          },
                          child: Text(
                            "Forget Password ?",
                            style: TextStyle(
                              fontSize: 15,
                              color:  Color(0xFF0F52BA),
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                      ),
                    ),
                    SizedBox(height: 12,),
                     Container(
                       height: 60,
                       child: ElevatedButton(
                
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(60),
                             backgroundColor: Color(0xFF0F52BA),
                              shape: RoundedRectangleBorder( //to set border radius to button
                                  borderRadius: BorderRadius.circular(50)
                              )),
                          onPressed: (){
                
                            if (formKey.currentState!.validate())
                            _signIn();
                                         },
                           child: Text("Login",style: TextStyle(color: Colors.white,fontSize:25),)),
                     ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?",style: TextStyle(fontSize: 15),),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>(Intro())));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF0F52BA),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                
                    Image.asset(
                      'assets/logo.png',
                      height: 350,
                      width: 350,
                    )
                    ],
                          ),
              ),
        ),
      ),
    ),
    ));
  }
  void _signIn() async {
    setState(() {
      isSigning = true;
    });

    String email = emailcontroller.text;
    String password = passwordcontroller.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      isSigning = false;
    });

    if (user != null) {
      showToastMsg(message: "User is successfully signed in");
      Navigator.pushReplacementNamed(context,  '/home',arguments: {'uid':user.uid });
    } //else {
      //showToastMsg(message: "some error occured");
    //}
  }
}
