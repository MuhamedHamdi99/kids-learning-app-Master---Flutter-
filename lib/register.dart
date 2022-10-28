
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kids/user.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'getstart.dart';
import 'package:sizer/sizer.dart';
import 'login.dart';
import 'user.dart';



class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  final _auth = FirebaseAuth.instance;
  String _email = "";
  String _pass = "";
  String num = "";
  String name = "";

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String collectionName = "Users";

  bool isloading = false;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: (){

        Navigator.push(context, MaterialPageRoute(builder: (context){

          return Login();
        }));
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 8.h,),
              Column(
                children: <Widget>[
                  Text("Sign Up" ,style: TextStyle(fontSize: 25.sp,color: Colors.amberAccent[700],fontWeight: FontWeight.bold),),
                  SizedBox(height: 1.h,),
                  Text("Create an free account ",style: TextStyle(fontSize: 12.sp,color: Colors.amberAccent[700]),)
                ],

              ),

              SizedBox(height: 9.h),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                    child: TextFormField(
                      onChanged: (value)
                      {
                        name=value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.w),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color(0xFFe7edeb),
                          hintText: "UserName",
                          prefixIcon: Icon(Icons.email,color: Colors.grey[800],size: 6.w,)
                      ),
                    ),
                  ),


                  SizedBox(height: 6.h,),
                  Padding(
                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                    child: TextFormField(
                      onChanged: (value){
                        _email=value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.w),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color(0xFFe7edeb),
                          hintText: "E-mail address",
                          prefixIcon: Icon(Icons.email,color: Colors.grey[800],size: 6.w,)
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h,),

                  Padding(
                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                    child: TextFormField(
                      onChanged: (value)
                      {
                        _pass=value;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.w),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color(0xFFe7edeb),
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock,color: Colors.grey[800],size: 6.w,)
                      ),
                    ),
                  ),

                  SizedBox(height: 6.h,),

                  Padding(
                    padding: EdgeInsets.only(left: 4.w,right: 4.w),
                    child: TextFormField(
                      onChanged: (value)
                      {
                        num=value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2.w),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Color(0xFFe7edeb),
                          hintText: "Phone Number",
                          prefixIcon: Icon(Icons.phone,color: Colors.grey[800],size: 6.w,)
                      ),
                    ),
                  ),

                  SizedBox(height: 6.h,),
                ],

              ),

              SizedBox(height:5.5.h,),

              Container(

                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10.w),
                  border: Border(
                    bottom: BorderSide(color: Colors.white38),
                    top: BorderSide(color: Colors.white38),
                    left: BorderSide(color: Colors.white38),
                    right: BorderSide(color: Colors.white38),
                  ),
                ),
                child: MaterialButton(

                  minWidth:50.w,
                  height: 7.h,
                  color: Colors.amberAccent[700],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
                  child: Text("Sign Up",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w600,color: Colors.white),),
                  onPressed: () async {

                    try {

                      if (_pass=="" && _email==""&&name=="")
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("All fields required "),backgroundColor: Colors.blueGrey,));

                      }
                      else if(_email==null || _email=="")
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("E-mail address  is Empty "),backgroundColor: Colors.blueGrey,));
                      }
                      else if(_pass==null || _pass=="")
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("password  is Empty "),backgroundColor: Colors.blueGrey,));
                      }
                      else if(name==""||name==null)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("UserName is  Empty "),backgroundColor: Colors.blueGrey,));
                      }
                      else if(num==""||num==null)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text ("Phone Number is  Empty "),backgroundColor: Colors.blueGrey,));
                      }

                      else {
                        final user = await _auth.createUserWithEmailAndPassword(
                            email: _email.trim(),
                            password: _pass.trim());

                        if(user!=null) {


                          final now = DateTime.now();
                          String date = DateFormat('dd-MM-yyyy  KK-mm').format(now);
                          var uniquekey = _firebaseFirestore.collection(collectionName).doc();

                     Child child =Child(name, _email,uniquekey.id, date, _email, num);
                            child.uploadDataUser(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return Login();
                          },),);
                        }else
                          {
                            showSimpleNotification(Text("No Internet" ,style: TextStyle(color: Colors.white),),background: Colors.red);
                          }

                      }
                    }on FirebaseAuthException catch(error)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text (error.message.toString(),),backgroundColor: Colors.blueGrey,));
                    }




                  },

                ),
              ),

              SizedBox(height: 3.h,),
            ],


          ),


        ),
      ),
    );
  }
}
