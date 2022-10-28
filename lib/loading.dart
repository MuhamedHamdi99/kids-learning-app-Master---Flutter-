

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kids/HomeScreen.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizer/sizer.dart';

class load extends StatefulWidget {
  @override
  _loadState createState() => _loadState();
}

class _loadState extends State<load> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.push(context,MaterialPageRoute(builder: (context){
          return  home();
        }));

      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("history ",style: TextStyle(fontSize: 16.sp,color: Colors.amberAccent[700]),),
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: Builder(
                builder:(context){
                  return IconButton(
                      onPressed: ()=>  Navigator.push(context,MaterialPageRoute(builder: (context){
                        return  home();
                      })),

                      icon:Icon( Icons.arrow_back_ios_outlined,color: Colors.amberAccent[700],size: 7.w,)  );
                }
            ),
            actions: [
              Padding(padding: EdgeInsets.only(right: 5.w),child: IconButton(icon: Icon(Icons.delete,size: 7.w,),color: Colors.amberAccent[700],onPressed: ()async{
                try {
                  final c = await InternetAddress.lookup("www.youtube.com");
                  if(c.isNotEmpty&&c[0].rawAddress.isNotEmpty)
                  {




                  }


                } on SocketException catch(_)
                {

                  showSimpleNotification(Text("No Internet , try later" ,style: TextStyle(color: Colors.white),),background: Colors.red);
                }



              },))
            ],
          ),
          backgroundColor: Colors.white,
          body: Center(child: CircularProgressIndicator(color: Colors.amberAccent[700],),)),
    );
  }
}
