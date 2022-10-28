import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';


class CollapsList extends StatefulWidget {


  final String title ;
  final IconData icon ;
  final VoidCallback Callback ;


  CollapsList({ this.title, this.icon,this.Callback});


  @override
  _CollapsListState createState() => _CollapsListState();
}

class _CollapsListState extends State<CollapsList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.Callback,
      child: Column(
          children  : <Widget>[ Row(
            children: <Widget>[
              Icon(widget.icon,color: Colors.amberAccent[700],size: 7.w,),
              SizedBox(width: 8.w,),
              Text(widget.title,style: TextStyle(color: Colors.amberAccent[700],fontSize: 14.sp,fontWeight: FontWeight.w600)),


            ],
          ),
            SizedBox(height: 10.h,),

          ]
      ),
    );
  }
}
