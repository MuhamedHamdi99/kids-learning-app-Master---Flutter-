
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kids/HelpInside.dart';
import 'package:kids/HomeScreen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'collapslist.dart';
import 'help.dart';
import 'navigationModel.dart';

import 'login.dart';


import 'package:sizer/sizer.dart';

class sidebar extends StatefulWidget {
  const sidebar({Key key}) : super(key: key);

  @override
  _sidebarState createState() => _sidebarState();
}

class _sidebarState extends State<sidebar> {


  final _auth = FirebaseAuth.instance;


  _saveData(bool state ) async
  {
    SharedPreferences  shared_data =await SharedPreferences.getInstance();

    shared_data.setBool("STATE",state);
  }

  _saveDataa(String name,String username , String Pass,bool state ) async
  {
    SharedPreferences  shared_data =await SharedPreferences.getInstance();
    shared_data.setString("NAME",name);
    shared_data.setString("USERNAME", username);
    shared_data.setString("PASS",Pass);
    shared_data.setBool("STATE",state);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55.w,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Padding(
          padding: EdgeInsets.only(left: 1.w),
          child: Column(
              children: <Widget> [
                SizedBox(height: 8.h,),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      CollapsList(title: navigationitems[0].title,icon:navigationitems[0].icon , Callback: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context){
                          return home();
                        }));
                      } ),
                      SizedBox(height: 5.h,),
                      CollapsList(title: navigationitems[1].title,icon:navigationitems[1].icon , Callback: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context){
                          return  HELPINSIDE();
                        }));
                      } ),
                      SizedBox(height: 5.h,),

                      CollapsList(title: navigationitems[2].title,icon:navigationitems[2].icon , Callback: ()async{

                     try {
                       final c = await InternetAddress.lookup("www.youtube.com");
                       if(c.isNotEmpty&&c[0].rawAddress.isNotEmpty)
                       {
                         try{
                           _auth.signOut();
                           _saveData(false);
                           _saveDataa("", "", "", false);
                           Navigator.push(context,MaterialPageRoute(builder: (context){
                             return Login();
                           }));
                         }  on FirebaseAuthException catch(error)
                         {
                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text (error.message.toString(),),backgroundColor: Colors.blueGrey,));
                         }
                       }
                     } on SocketException catch(_)
                     {
                       showSimpleNotification(Text("No Internet" ,style: TextStyle(color: Colors.white),),background: Colors.red);
                     }
                      } ),
                    ],
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
