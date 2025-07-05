import 'package:flutter/material.dart';
import 'package:skinscan_ai/pages/chat_assitant/MediMate.dart';
import 'package:skinscan_ai/pages/profile.dart';
import 'package:skinscan_ai/pages/testing.dart';
import 'package:skinscan_ai/pages/detials.dart';
import 'package:skinscan_ai/pages/Map/tracking.dart';
import '../features/toast.dart';
import 'login.dart';

class Home extends StatefulWidget{
  @override
  HomeView createState() {
    return  HomeView();
  }
}
class HomeView extends State<Home>{
  Map? data;
  @override
  Widget build(BuildContext context) {
    data= ModalRoute.of(context)?.settings.arguments as Map?;

    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
              'SkinScan AI',
              style:TextStyle(fontSize: 50,fontWeight:FontWeight.w300)),
          actions: [
            ProfileIcon(data),
          ],
        ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(25,150,25,25),
            child: Column(
              children: [
        
                ElevatedButton(
        
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60),
                        backgroundColor:  Color(0xFF0F52BA),
                        shape: RoundedRectangleBorder( //to set border radius to button
                            borderRadius: BorderRadius.circular(50)
                        )),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Testing(docId: data?['uid']),));
        
                    },
                    child: Text("Take Test",style: TextStyle(color: Colors.white,fontSize:25),)),
                SizedBox(height: 30,),
                ElevatedButton(
        
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60),
                        backgroundColor:  Color(0xFF0F52BA),
                        shape: RoundedRectangleBorder( //to set border radius to button
                            borderRadius: BorderRadius.circular(50)
                        )),
                    onPressed: (){
                      Navigator.pushNamed(context,'/details');
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=>Details()));
                    },
                    child: Text("Disease Info",style: TextStyle(color: Colors.white,fontSize:25),)),
                SizedBox(height: 30,),
                ElevatedButton(
        
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(60),
                        backgroundColor:  Color(0xFF0F52BA),
                        shape: RoundedRectangleBorder( //to set border radius to button
                            borderRadius: BorderRadius.circular(50)
                        )),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Tracking()));
                    },
                    child: Text("Hospitals Nearby",style: TextStyle(color: Colors.white,fontSize:25),))
        
              ],
            ),
          ),
        ),
      ),

    );
  }
}

class ProfileIcon extends StatelessWidget {
  Map? data;
  ProfileIcon(Map? data){
    this.data=data;
  }

  @override
  Widget build(BuildContext context) {
    print(data?['email']);
    return PopupMenuButton<String>(
      color: Colors.grey[200],
      icon: CircleAvatar(
        backgroundImage: AssetImage("assets/profileicon.jpg"),
      ),
      offset: Offset(0, 50),

      onSelected: (String result) {
        if (result=='Profile')
          Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => Profile(docId: data?['uid']),));// Pass the docId here
        else if (result=='MediMate')
          Navigator.push(context, MaterialPageRoute(builder: (context) => MediMate()));

        else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
          showToastMsg(message: "Successfully Logout");
        }


      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Profile',
          child: Text('Profile'),
        ),
        PopupMenuItem<String>(
          value: 'MediMate',
          child: Text('MediMate'),
        ),
        PopupMenuItem<String>(
          value: 'Logout',
          child: Text('Logout'),
        ),
      ],
    );
  }
}
