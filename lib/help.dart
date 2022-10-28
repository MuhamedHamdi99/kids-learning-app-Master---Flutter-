

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:kids/getstart.dart';


import 'package:carousel_slider/carousel_slider.dart';
import 'package:kids/login.dart';
import 'package:kids/HomeScreen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sizer/sizer.dart';



class help extends StatefulWidget {
  @override
  _helpState createState() => _helpState();
}

class _helpState extends State<help> {

CarouselController control = CarouselController();
int activeIndex =0;
  final images =[

        "assets/1.jpg",
        "assets/22.jpg",
        "assets/3.jpg",
        "assets/4.jpg",
        "assets/5.jpg",
         "assets/10.jpg",
        "assets/6.jpg",
        "assets/7.jpg",
        "assets/8.jpg",


  ];


  _help(bool help)async
  {

    SharedPreferences  help_data =await SharedPreferences.getInstance();
    help_data.setBool("HELP",help);

  }


@override
  Widget build(BuildContext context) {



  return WillPopScope(
      onWillPop: () {

        SystemNavigator.pop();
      }
      ,child: Scaffold(
        appBar: AppBar(
          title: Text("Help",style: TextStyle(fontSize: 16.sp,color: Colors.amberAccent[700]),),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: Builder(
              builder:(context){
                return IconButton(
                    onPressed: (){


                        SystemNavigator.pop();

                    },

                    icon:Icon( Icons.arrow_back_ios_outlined,color: Colors.amberAccent[700],size: 7.w,)  );
              }
          ),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children:<Widget> [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  SizedBox(height: 2.h,),
                  CarouselSlider.builder(
                    carouselController: control,
                    options:CarouselOptions(
                        height:66.h,
                        //    reverse: true,
                        //viewportFraction: 1,
                        initialPage: 0,
                        enlargeCenterPage: true,
                        enlargeStrategy:CenterPageEnlargeStrategy.height,
                        enableInfiniteScroll: false,

                        onPageChanged: (index , reason)
                        {
                          setState(() {
                            activeIndex=index;
                          });

                        }

                    ),
                    itemCount: images.length,
                    itemBuilder: (context,index,realIndex)
                    {
                      final image =images[index];
                      return Container(

                          margin:  EdgeInsets.symmetric(horizontal: 2.w),
                          color:Colors.grey,
                          child: Image.asset(image,fit: BoxFit.cover,)
                      );

                    },


                  ),


                  SizedBox(height: 3.h,),

                  AnimatedSmoothIndicator(
                    activeIndex: activeIndex,
                    count: images.length,

                    effect: SlideEffect
                      (
                      dotHeight: 3.h,
                      dotWidth: 6.w,
                      activeDotColor: Colors.amberAccent[700],
                      dotColor: Colors.black12,
                    ),


                  ),

                  SizedBox(height: 2.h,),

                ],
              ),



              Padding(padding:EdgeInsets.only(right: 5.w,top: 5.h),
                      child: GestureDetector(

                    onTap: (){



                      _help(true);

                     // if(getstart.help==false)
                      //  {

                          Navigator.push(context,MaterialPageRoute(builder: (context){
                            return  Login();
                          }));


                     //   }
                     // else
                       // {

                       //   Navigator.push(context,MaterialPageRoute(builder: (context){
                      //      return  home();
                      //    }));

                    //    }





                    },

                    child: Text("next >",style: TextStyle(color: Colors.amberAccent[700],fontSize: 20.sp,fontWeight: FontWeight.w400),)

                ),
              ),




            ],

          ),
        )
    ),

    );
  }
}
