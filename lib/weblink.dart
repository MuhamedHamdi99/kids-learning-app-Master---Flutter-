import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:sizer/sizer.dart';
class web extends StatefulWidget {
  String link;
  web(this.link);
  @override
  _webState createState() => _webState();
}
class _webState extends State<web> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        },icon: Icon(Icons.arrow_back,size: 7.w,),color: Colors.amberAccent[700],),
        elevation:0,
        title: Text("Images",style: TextStyle(fontSize: 16.sp,color: Colors.amberAccent[700]),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: WebView(
        initialUrl: widget.link,
        javascriptMode: JavascriptMode.unrestricted,
        zoomEnabled: true,
      ),
    );
  }
}
