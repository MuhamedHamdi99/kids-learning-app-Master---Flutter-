import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:kids/weblink.dart';
import 'package:overlay_support/overlay_support.dart';
import 'HomeScreen.dart';
import 'getstart.dart';

class Child
{
   String userName ;
   String E_mail ;
   String pass;
   String Id ;
   String date ;
   String id ;
   String phone ;
   Child(this.userName, this.E_mail, this.Id, this.date, this.id, this.phone);
   Child.online(this.E_mail, this.pass);
  void uploadDataUser(BuildContext context) async
   {
      FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
      String collectionName = "Users";
      try{
         _firebaseFirestore.collection(collectionName).doc(Id).set({
            "id": E_mail,
            "Id": Id,
            "userName":userName,
            "E-mail":E_mail,
            "phone":phone,
            "date": date,
         });

      } catch (e){

         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text (e.toString(),),backgroundColor: Colors.blueGrey,));
      }
   }

   Future spelling(String text)async

   {

      final FlutterTts _flutterTts =FlutterTts();
      await _flutterTts.setLanguage("en-AU");
      await _flutterTts.setPitch(5);

      await _flutterTts.setSpeechRate(.4);
      await _flutterTts.speak(text);

   }


   void ShowMore (BuildContext context ,String link)
   {


     if(link=="")

     {

       showSimpleNotification(Text("some thing wrong , try later " ,style: TextStyle(color: Colors.white),),background: Colors.red);
     }

     else

     {

       //         launch("https://www.google.com/search?q=$tLink%5D&sxsrf=APq-WBu9hQMhmFK-dacxJI3G1IexEcdSFw:1649632536958&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjn6v-K0Ir3AhUC3qQKHaaJBGEQ_AUoAXoECAMQAw&biw=1396&bih=685&dpr=1.38");

       Navigator.push(context,
           MaterialPageRoute(builder: (context) {
             return web("https://www.google.com/search?q=$link%5D&sxsrf=APq-WBu9hQMhmFK-dacxJI3G1IexEcdSFw:1649632536958&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjn6v-K0Ir3AhUC3qQKHaaJBGEQ_AUoAXoECAMQAw&biw=1396&bih=685&dpr=1.38");
           }
           )
       );

     }
   }




}