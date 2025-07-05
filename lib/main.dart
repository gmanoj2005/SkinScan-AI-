import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skinscan_ai/pages/chat_assitant/MediMate.dart';
import 'package:skinscan_ai/pages/detials.dart';
import 'package:skinscan_ai/pages/editprofile.dart';
import 'package:skinscan_ai/pages/home.dart';
import 'package:skinscan_ai/pages/intro.dart';
import 'package:skinscan_ai/pages/login.dart';
import 'package:skinscan_ai/pages/passwordreset.dart';
import 'package:skinscan_ai/pages/passwordresetmailresend.dart';
import 'package:skinscan_ai/pages/profile.dart';
import 'package:skinscan_ai/pages/signup.dart';
import 'package:skinscan_ai/pages/signup2.dart';
import 'package:skinscan_ai/pages/testing.dart';
import 'package:skinscan_ai/pages/Map/tracking.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyDn9xHYRDF0vRQeYkrfccfU43dgtTC3ZKM',
        appId: '1:15123276780:web:9172c5093d7c93e86856c9',
        messagingSenderId: '15123276780',
        projectId: 'skinscan-ai',
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MaterialApp(



    
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes:{'/login':(context)=>Login(),
        '/home':(context)=>Home(),
        '/signup':(context)=>SignUp(),
        '/signup2':(context)=>SignUp2(),
        '/editprofile':(context)=>EditProfile(docId: '',),
        '/profile':(context)=>Profile(docId: '',),
        '/testing':(context)=>Testing(docId: '',),
        '/tracking':(context)=>Tracking(),
        '/details':(context)=>Details(),
        '/medimate':(context)=>MediMate(),
        '/intro':(context)=>Intro(),
        '/passwordreset':(context)=>ResetPwPage(),
        '/passwordresetmailresend':(context)=>PasswordResetResentPage(mail: '',),
      })
  );
}



