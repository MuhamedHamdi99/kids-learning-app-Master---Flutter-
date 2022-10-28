
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kids/detailShape.dart';

import 'package:kids/getstart.dart';
import 'package:kids/HomeScreen.dart';
import 'package:lottie/lottie.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:tflite/tflite.dart';
import 'loading.dart';
import 'package:sizer/sizer.dart';



class history extends StatefulWidget {
  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {



  FirebaseFirestore _firebaseFirestore =FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage= FirebaseStorage.instance;
  FirebaseAuth _auth =FirebaseAuth.instance;
  String collectionName="Image";
  String userid;
  String userdata ="Images";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();




  }


  Future<void> refrshpage() {


    Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (a,b,c)=>history(),transitionDuration: Duration(seconds: 0)));
  }


  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () {

        Navigator.push(context,MaterialPageRoute(builder: (context){
          return  home();
        }));

      }

      ,child: Scaffold(
        appBar: AppBar(
          title: Text("history",style: TextStyle(fontSize: 16.sp,color: Colors.amberAccent[700]),),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: Builder(
              builder:(context){
                return IconButton(
                    onPressed: ()=>  Navigator.push(context,MaterialPageRoute(builder: (context){
                      return  home();
                    })),

                    icon:Icon( Icons.arrow_back_ios_outlined,color: Colors.amberAccent[700],size: 7.w,)  );
              }
          ),
          elevation: 0,
          actions: [

            Padding(padding: EdgeInsets.only(right: 2.5.w),child: IconButton(icon: Icon(Icons.delete,size: 7.w,),color: Colors.amberAccent[700],onPressed: ()async{


              try {
                final c = await InternetAddress.lookup("www.youtube.com");
                if(c.isNotEmpty&&c[0].rawAddress.isNotEmpty)
                {
                  var collection = FirebaseFirestore.instance.collection(collectionName);
                  var snapshots = await collection.get();
                  for (var doc in snapshots.docs) {
                    await doc.reference.delete();
                  }
                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return  history();
                  }));
                }
              } on SocketException catch(_)
              {

                showSimpleNotification(Text("No Internet , try later" ,style: TextStyle(color: Colors.white),),background: Colors.red);
              }
            },))
          ],
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child:RefreshIndicator(
              onRefresh: refrshpage,
              child: Column(
                  children: <Widget>[
                       Expanded(
                          child: FutureBuilder<QuerySnapshot>(
                        future:   _firebaseFirestore.collection(collectionName).where('id',isEqualTo: getstart.name_user).get(),
                            builder: (context,snapshot) {

                              try {
                                if(!snapshot.hasData)
                                {
                                  return Center(child: CircularProgressIndicator(color: Colors.amberAccent[700],),);
                                }

                                if(snapshot.data.size!=0)
                                {
                                  List<DocumentSnapshot> photos =snapshot.data.docs;
                                  return ListView.builder(
                                      itemCount: photos.length,
                                      itemBuilder: (context,index){
return shape(photos[index]);

                                      }
                                  );
                                }
                                else
                                {
                                  return Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(10.w)),
                                      ),
                                      child:  Lottie.asset("assets/no-data.json",fit: BoxFit.fill),
                                      height:40.h,
                                      width: 90.w,
                                    ),

                                  );
                                }
                              } on SocketException catch(_)
                              {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return load();
                                    }
                                    )
                                );
                                showSimpleNotification(Text("No Internet" ,style: TextStyle(color: Colors.white),),background: Colors.red);
                              }
                          }
                      )
                      ),
                  ],
                ),
            ),
            ),
        ),
    );
  }
}

class shape extends StatelessWidget
{


  FirebaseFirestore _firebaseFirestore =FirebaseFirestore.instance;
  FirebaseStorage _firebaseStorage= FirebaseStorage.instance;
  FirebaseAuth _auth =FirebaseAuth.instance;
  String collectionName="Image";
  String userid;
  String userdata ="Images";



  DocumentSnapshot data ;


shape(this.data);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  GestureDetector(
      onTap: ()
      {
        Navigator.push(context,MaterialPageRoute(builder: (context){
          return  detail(data);
        }));

      },
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: Material(
          elevation: 2,
          child: Container(
            height: 18.h,
            width: 95.w,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget> [

                Padding(
                  padding: EdgeInsets.all(.5.w)
                  ,child: Container(

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.w), bottomRight: Radius.circular(10.w)),
                  )
                  ,child:
              Hero(
                tag: "99",
                child:   Image.network(
                  data['image'],
                  height: 18.h,
                  width: 33.w,
                  fit: BoxFit.fill,
                  loadingBuilder:(context,child,loading){

                    if(loading==null)
                    {
                      return child;
                    }
                    else
                    {
                      return Padding(
                        padding: EdgeInsets.only(left:4.1.w ),
                        child: Center(
                          child: CircularProgressIndicator(
                            value:loading.expectedTotalBytes !=null ?loading.cumulativeBytesLoaded/loading.expectedTotalBytes :null ,color: Colors.amberAccent[700],),
                        ),
                      );
                    }
                  },),
              )
                ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    SizedBox(height: 1.h,),
                    Text(data['title'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp,color: Colors.amberAccent[700]),),

                    SizedBox(height: 5.h,),

                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Center(child:
                      Text(data['date'].toString(),style: TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),),),
                    ),

                    SizedBox(width: 7.w,),
                  ],
                ),

                IconButton(onPressed: () async {

                  _firebaseFirestore.collection(collectionName).doc(data['Id']).delete();
                  var fileUrl = Uri.decodeFull(p.basename(data['image'])).replaceAll(new RegExp(r'(\?alt).*'), '');
                  FirebaseStorage.instance.ref().child(fileUrl).delete();


                  Navigator.push(context,MaterialPageRoute(builder: (context){
                    return  history();
                  }));


                }, icon:Icon(Icons.delete,color: Colors.black87,size: 7.w,) )

              ],
            ) ,),
        ),
      ),
    );
  }


}
