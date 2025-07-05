import 'package:skinscan_ai/features/userauthentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skinscan_ai/pages/signup.dart';
import '../features/toast.dart';
import 'home.dart';
import 'login.dart';
class SignUp2 extends StatefulWidget{
  @override
  UserSignUp2  createState(){
    return  UserSignUp2();
  }

}

class  UserSignUp2 extends State<SignUp2>{
  TextEditingController emailcontroller=TextEditingController();
  TextEditingController  passwordcontroller=TextEditingController();
  TextEditingController confirmpasswordcontroller=TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();
  Map? data;
  bool notVisible=true;
  bool notvisible=true;
  bool isSigningUp = false;
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    confirmpasswordcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    data= ModalRoute.of(context)?.settings.arguments as Map?;
    print(data);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(backgroundColor: Colors.white,),
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(25, 0, 25, 25),
            child: Center(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("SignUp", style: TextStyle(fontSize: 50), textAlign: TextAlign.center),
                        SizedBox(width: 10),
                        IconButton(
                          icon: Icon(Icons.info_outline, color: Colors.red, size: 30),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text("SignUp Requirements",
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                content: SingleChildScrollView( // Prevents overflow
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.8, // Adjust width dynamically
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.check_circle, color: Colors.green),
                                            SizedBox(width: 8),
                                            Expanded( // Prevents text overflow
                                              child: Text("First Name: Must be valid name",style:TextStyle(fontSize: 15)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(Icons.check_circle, color: Colors.green),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text("Last Name: Must be valid name",style:TextStyle(fontSize: 15)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Icon(Icons.check_circle, color: Colors.green),
                                            SizedBox(width: 8),
                                            Expanded(
                                              child: Text("Phone No: Must be 10 digits",style:TextStyle(fontSize: 15)),
                                            ),
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            Icon(Icons.check_circle, color: Colors.green),
                                            SizedBox(width: 8),
                                            Expanded( // Prevents text overflow
                                              child: Text("Email: Must be valid Mail ID",style:TextStyle(fontSize: 15)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.check_circle, color: Colors.green),
                                            SizedBox(width: 8),
                                            Expanded( // Prevents text overflow
                                              child: Text("Password: Must have ",style:TextStyle(fontSize: 15)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(width: 8),
                                            Expanded( // Prevents text overflow
                                              child: Text("      UpperCase, LowerCase, Digit,",style:TextStyle(fontSize: 15)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(width: 8),
                                            Expanded( // Prevents text overflow
                                              child: Text("      Special Character(%,!,@,#,",style:TextStyle(fontSize: 15)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(width: 8),
                                            Expanded( // Prevents text overflow
                                              child: Text("      \$,&,*,~) and Min length of 8",style:TextStyle(fontSize: 15)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text("OK", style: TextStyle(color:  Color(0xFF0F52BA))),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),

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

                    TextFormField(
                      style: TextStyle(fontSize: 20),
                      cursorColor: Colors.black,
                      obscureText: notVisible,
                      controller: passwordcontroller,
                      validator: (String? value) {
                        RegExp pwRegex =
                        RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[%!@#\$&*~]).{8,}$');
                        if (value!.isEmpty) {
                          return 'Enter Your Password';
                        } else {
                          if (!pwRegex.hasMatch(value!)) {
                            return 'Enter Valid Password';
                          } else {
                            return null;
                          }
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
                    SizedBox(height: 12,),

                    TextFormField(
                      style: TextStyle(fontSize: 20),
                      cursorColor: Colors.black,
                      obscureText: notvisible,
                      controller: confirmpasswordcontroller,
                      validator: (String? value) {

                        if (value!.isEmpty)
                          return 'Enter Your Confirm Password';
                        else if(confirmpasswordcontroller.text!=passwordcontroller.text)
                                        return 'Passwords Are Not Same';
                          else
                            return null;

                        },

                      decoration: InputDecoration(
                        // floatingLabelStyle: TextStyle(color:elabel? Colors.blue:Colors.red),
                        labelStyle: TextStyle(fontSize: 20),
                        labelText: "Confirm Password",
                        suffixIcon: IconButton(
                            color: Colors.black,
                            onPressed: (){
                              setState(() {
                                notvisible=!notvisible;
                              });
                            },
                            icon:notvisible?Icon(Icons.visibility_off):Icon(Icons.visibility)),
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
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Container(
                          height: 60,
                          width: 163,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                //minimumSize: const Size.fromHeight(60),
                                  backgroundColor: Color(0xFF0F52BA),
                                  shape: RoundedRectangleBorder( //to set border radius to button
                                      borderRadius: BorderRadius.circular(50)
                                  )),
                              onPressed: () {
                                  //Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Text("Previous", style: TextStyle(
                                  color: Colors.white, fontSize: 25),)),
                        ),
                          SizedBox(width: 8,),
                          Container(
                            height: 60,
                            width: 163,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(

                                  // minimumSize: const Size.fromHeight(60),
                                    backgroundColor: Color(0xFF0F52BA),
                                    shape: RoundedRectangleBorder( //to set border radius to button
                                        borderRadius: BorderRadius.circular(50)
                                    )),
                                onPressed: () {
                                  if (formKey.currentState!.validate())
                                    _signUp(data!);
                                  //Navigator.pushReplacement(
                                  //context, MaterialPageRoute(builder: (context) =>
                                  //  Home()));
                                },
                                child: Text("SignUp", style: TextStyle(
                                    color: Colors.white, fontSize: 25),)),
                          ),

                        ]
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",
                          style: TextStyle(fontSize: 15),),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(context, "/login", (r) => false);
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF0F52BA),
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
  void _signUp(Map data) async {

    setState(() {
      isSigningUp = true;
    });

    String firstname =data['firstname'];
    String lastname =data['lastname'];
    String phonenumber =data['phonenumber'];
    String email = emailcontroller.text;
    String password = passwordcontroller.text;
    String e=email;
    User? user = await _auth.signUpWithEmailAndPassword(firstname,lastname,phonenumber,email,password);

    setState(() {
      isSigningUp = false;
    });
    if (user != null) {
      showToastMsg(message: "User is successfully created");

      Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false,arguments: {'uid':user.uid });
    } //else {
    //showToastMsg(message: "Some error happend");
    //}
  }
}
