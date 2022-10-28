

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class navigationmodel{
  String title ;
  IconData icon ;
  navigationmodel({  this.title,  this.icon});
}
List<navigationmodel> navigationitems =[
  navigationmodel(title: "Home Page" ,icon: Icons.home,),
  navigationmodel(title: "Help" ,icon: Icons.help_outline),
  navigationmodel(title: "Log Out" ,icon: Icons.logout),

];