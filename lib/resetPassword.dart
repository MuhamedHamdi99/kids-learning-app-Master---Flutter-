
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'getstart.dart';
import 'login.dart';
import 'package:sizer/sizer.dart';
class data extends StatefulWidget {
  @override
  _dataState createState() => _dataState();
}

class _dataState extends State<data> {


  String _email="";
  String password="";
  String confirmPass="";
  String pass="";




  FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  void initState() {


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
            builder:(context){
              return IconButton(
                  onPressed: ()=>  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return  Login();
                  })),

                  icon:Icon( Icons.arrow_back_ios_outlined,color: Colors.amberAccent[700],size: 7.w,)  );
            }
        ),
        centerTitle: true,
        title:Text("Personal Data",style: TextStyle(color: Colors.amberAccent[700],fontSize: 16.sp),) ,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        scrollDirection: Axis.vertical,

        children: <Widget>[

          SizedBox(height: 20.h,),


          Center(child: Text("Reset New Password",style: TextStyle(color: Colors.amberAccent[700],fontWeight: FontWeight.bold,fontSize: 18.sp),)),

          SizedBox(height: 10.h,),
          Padding(
            padding: EdgeInsets.only(left: 5.w, right: 5.w),
            child: TextFormField(

              onChanged: (value)async {
                _email=value;


              }
              ,
              keyboardType: TextInputType.emailAddress,

              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.w),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Color(0xFFe7edeb),
                  hintText: "E-mail address",
                  prefixIcon: Icon(Icons.email, color: Colors.grey[800],size: 7.w,)
              ),
            ),
          ),
SizedBox(height: 20.h,),


          Padding(
            padding: EdgeInsets.only(left: 17.w,right: 17.w),
            child: MaterialButton(

              minWidth: 50.w,
              height: 6.h,

              color: Colors.amberAccent[700],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.w)),
              child: Text("Set Password", style: TextStyle(fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),),
              onPressed: () async {


                   if (_email == null || _email == "") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("E-mail address is Empty "),
                      backgroundColor: Colors.blueGrey,));
                  }

                  else {


                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context){
return Center(child: CircularProgressIndicator(),);

                    });

                    try {


                      try {
                        final c = await InternetAddress.lookup("www.youtube.com");
                        if(c.isNotEmpty&&c[0].rawAddress.isNotEmpty)
                        {

if(_email.trim()=="")
  {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Enter E-mail "),duration: Duration(milliseconds: 1200),
      backgroundColor: Colors.blueGrey,));

  }
else
  {
    _auth.sendPasswordResetEmail(email: _email.trim());
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("password Reset, E-mail sent "),duration: Duration(milliseconds: 2650),
      backgroundColor: Colors.blueGrey,));

    Navigator.push(context, MaterialPageRoute(builder: (context){
      return Login();
    }));

  }


                        }

                      } on SocketException catch(_)
                      {

                        showSimpleNotification(Text("No Internet" ,style: TextStyle(color: Colors.white),),background: Colors.red);
                      }



                    } on FirebaseAuthException catch(e)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(e.message),
                        backgroundColor: Colors.blueGrey,));
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Login();
                      }));

                    }




                  }
                }










            ),
          ),





        ],

      ),
    );
  }
}
