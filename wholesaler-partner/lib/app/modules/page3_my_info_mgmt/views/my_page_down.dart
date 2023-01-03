import 'package:flutter/material.dart';

class MyPageDownP extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("APP'S DEVELOPER PAGE") ),
      body: Center(child: Text("MADE BY SEUNG HAN CHA",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
    );
  }
}
