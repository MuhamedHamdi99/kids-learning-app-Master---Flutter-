
import 'dart:async';
import 'dart:io';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:kids/help.dart';
import 'package:kids/HomeScreen.dart';

import 'package:lottie/lottie.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sizer/sizer.dart';
import 'login.dart';

class getstart extends StatefulWidget {





  static String Name="";
  static String name_user ="";

  static String phone="";
  static bool state=false;
  static bool help=false;


  @override
  _getstartState createState() => _getstartState();
}

class _getstartState extends State<getstart> with TickerProviderStateMixin{


bool hasinternet;

ConnectivityResult result = ConnectivityResult.none;

StreamSubscription _subscription;

StreamSubscription _subscriptionno;


AnimationController _coffeeController;
bool copAnimated = false;
bool animateCafeText = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _coffeeController = AnimationController(vsync: this);
    _coffeeController.addListener(() {
      if (_coffeeController.value > 0.9999) {
        _coffeeController.stop();
        copAnimated = true;
        setState(() {});
        Future.delayed(const Duration(seconds: 1), () {
          animateCafeText = true;
          setState(() {});
        });
      }
    });



    _loadData();



  _subscription=  Connectivity().onConnectivityChanged.listen((event) {

      setState(() {
        result=event;
      });

    });

   _subscriptionno= InternetConnectionChecker().onStatusChange.listen((event) {
      final net =event ==InternetConnectionStatus.connected;
setState(() {

  hasinternet=net;
});
    });
  }


@override
  void dispose() {

    _subscription.cancel();
    _subscriptionno.cancel();
    _coffeeController.dispose();
    super.dispose();

  }






_loadData()async{
    SharedPreferences  shared_data =await SharedPreferences.getInstance();
    setState(() {

      if(shared_data.getString("NAME")!=""||shared_data.getString("USERNAME")!=""||shared_data.getString("PHONE")!=""||shared_data.getBool("STATE")==false) {
        getstart.Name = shared_data.getString("NAME");
        getstart.name_user = shared_data.getString("USERNAME");
        getstart.phone = shared_data.getString("PHONE");
        getstart.state = shared_data.getBool("STATE");
      }
      else
      {
        getstart.Name="";
        getstart.name_user="";
        getstart.phone="";
        getstart.state=false;
      }
    });
  }



@override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: (){
          SystemNavigator.pop();
        },
        child: Scaffold(
      backgroundColor: Colors.amberAccent[700],
      body: SingleChildScrollView(
        child: Column(
            children: [
              // White Container top half
              AnimatedContainer(
                duration:  Duration(seconds: 1),
                height: copAnimated ? 50.h: 100.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(copAnimated ? 10.w : 0.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Visibility(
                      visible: !copAnimated,
                      child: Container(
                        child: Column(
crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

Container(

  color: Colors.white,
  width:60.w,
  height: 30.h,
  child: Image.asset("images/Kids-Vector-Logo.png"),
),
                            Lottie.asset(
                              'images/lf20_dq66flxb (1).json',
                                height: 22.h,
                                width: 100.w
                                ,
                              controller: _coffeeController,
                              fit: BoxFit.cover,
                              onLoaded: (composition) {
                                _coffeeController
                                  ..duration = composition.duration
                                  ..forward();
                              },
                            ),
                          ],
                        )
                      ),
                    ),
                    SizedBox(height: 1.h,),
                    Visibility(
                      visible: copAnimated,
                      child: Lottie.asset(
                        'assets/learn.json',
                        width: 50.w,
                        height: 30.h,
                      ),
                    ),

                  ],
                ),
              ),

              SizedBox(height: 4.h,),
              // Text bottom part
              Visibility(visible: copAnimated, child:  _BottomPart()),
            ],
          ),
      ),
      ),
    

    );
  }
}


class _BottomPart extends StatefulWidget {
  @override
  __BottomPartState createState() => __BottomPartState();
}

class __BottomPartState extends State<_BottomPart> {


  _saveData(String name,String username , String phone,bool state ) async
  {
    SharedPreferences  shared_data =await SharedPreferences.getInstance();
    shared_data.setString("NAME",name);
    shared_data.setString("USERNAME", username);
    shared_data.setString("PHONE",phone);
    shared_data.setBool("STATE",state);
  }



  _help(bool help)async
  {

    SharedPreferences  help_data =await SharedPreferences.getInstance();
    help_data.setBool("HELP",help);

  }


  NeedHelp()async{
    SharedPreferences  help_data =await SharedPreferences.getInstance();
    setState(() {

      if(help_data.getBool("HELP")==false)
      {
        getstart.help = help_data.getBool("HELP");
      }
      else
      {
        getstart.help=true;
      }

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NeedHelp();

  }

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Text(
              'Discover The World With Us .',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
             SizedBox(height:7.h ),
            Text(
              'we have many features to help you to learn and know details about things . '
                  'so get started now with us . ',
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.white.withOpacity(0.8),
                height: .2.h,
              ),
            ),
             SizedBox(height: 8.h),
            GestureDetector(
              onTap: () async
              {

                try {
                  final c = await InternetAddress.lookup("www.youtube.com");
                  if(c.isNotEmpty&&c[0].rawAddress.isNotEmpty)
                  {
                //    _saveData("", "", "", false);
                  //   _help(false);

                    if(getstart.help==false)
                    {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return help();
                          }
                          )
                      );

                    }
                    else
                    {


                      if (getstart.state ==false) {

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return Login();
                            }
                            )
                        );

                      }
                      else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return home();
                            }
                            )
                        );
                      }

                    }


                  }
                  else
                  {
                    showSimpleNotification(Text("No Internet" ,style: TextStyle(color: Colors.white),),background: Colors.red);
                  }


                } on SocketException catch(_)
                {
                  showSimpleNotification(Text("No Internet" ,style: TextStyle(color: Colors.white),),background: Colors.red);
                }

              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 12.h,
                  width: 30.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: .5.w),
                  ),
                  child:  Icon(
                    Icons.chevron_right,
                    size: 20.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
             SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}


