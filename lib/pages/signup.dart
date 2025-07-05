
import 'package:skinscan_ai/features/userauthentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skinscan_ai/pages/signup2.dart';
import '../features/toast.dart';
import 'home.dart';
import 'login.dart';
class SignUp extends StatefulWidget{
  @override
  UserSignUp  createState(){
    return  UserSignUp();
  }

}

class  UserSignUp extends State<SignUp>{
  TextEditingController firstnamecontroller=TextEditingController();
  TextEditingController lastnamecontroller=TextEditingController();
  TextEditingController phonenumbercontroller=TextEditingController();
  final FirebaseAuthService _auth = FirebaseAuthService();
  final formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    firstnamecontroller.dispose();
    lastnamecontroller.dispose();
    phonenumbercontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
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
                     controller: firstnamecontroller,
                      validator: (String? value) {
                        if (0 == value!.length)
                          return " Enter Your First Name ";
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        // floatingLabelStyle: TextStyle(color:focusNode.hasFocus? Colors.blue:Colors.grey[600]),
                        //labelStyle: TextStyle(fontSize: 20, color: Colors.green),
                        labelText: "First Name",
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
                          icon:Icon(Icons.person),
                          onPressed: () {  },
                          // filled: true,

                        ),
                      ),
                    ),
                    SizedBox(height: 12,),

                    TextFormField(
                      style: TextStyle(fontSize: 20),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.name,
                      controller: lastnamecontroller,
                      validator: (String? value) {
                        if (0 == value!.length)
                          return " Enter Your Last Name ";
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        // floatingLabelStyle: TextStyle(color:focusNode.hasFocus? Colors.blue:Colors.grey[600]),
                        //labelStyle: TextStyle(fontSize: 20, color: Colors.green),
                        labelText: "Last Name",
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
                          icon:Icon(Icons.person),
                          onPressed: () {  },
                          // filled: true,

                        ),
                      ),
                    ),
                    SizedBox(height: 12,),

                    TextFormField(
                      style: TextStyle(fontSize: 20),
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      controller: phonenumbercontroller,
                      validator: (String? value) {
                        if (0 == value!.length)
                          return " Enter Your Phone Number ";
                        else {
                          if(!(10==value!.length))
                            return " Enter Valid Phone Number ";
                          else
                          return null;
                          }
                      },
                      decoration: InputDecoration(
                        // floatingLabelStyle: TextStyle(color:focusNode.hasFocus? Colors.blue:Colors.grey[600]),
                        //labelStyle: TextStyle(fontSize: 20, color: Colors.green),
                        labelText: "Phone Number",
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
                          icon:Icon(Icons.phone),
                          onPressed: () {  },
                          // filled: true,

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
                              backgroundColor:Colors.blue[100],
                              shape: RoundedRectangleBorder( //to set border radius to button
                                  borderRadius: BorderRadius.circular(50)
                              )),
                          onPressed: () {},
                          child: Text("Previous", style: TextStyle(
                              color: Colors.grey[700], fontSize: 25),)),
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
                                Navigator.pushNamed(
                                    context,
                                    '/signup2',
                                    arguments:{
                                      'firstname':firstnamecontroller.text,
                                      'lastname':lastnamecontroller.text,
                                      'phonenumber':phonenumbercontroller.text,
                                    });
                              //Navigator.pushReplacement(
                              //context, MaterialPageRoute(builder: (context) =>
                              //  Home()));
                            },
                            child: Text("Next", style: TextStyle(
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
                                  color:  Color(0xFF0F52BA),
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
  /*
    void _signUp() async {

      setState(() {
        isSigningUp = true;
      });

      String username = namecontroller.text;
      String email = emailcontroller.text;
      String password = passwordcontroller.text;

      User? user = await _auth.signUpWithEmailAndPassword(username,email, password);

      setState(() {
        isSigningUp = false;
      });
      if (user != null) {
        showToastMsg(message: "User is successfully created");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
      } //else {
        //showToastMsg(message: "Some error happend");
      //}
    }*/
  }
