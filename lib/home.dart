

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  
  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}


class _HomePageState extends State<HomePage> {
  void _onPress() {
    
  }

  @override
  Widget build(BuildContext context) { 
    return Container(
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Image.asset('assets/ts_logo.png', width: 200),
        ],
      ),
    );
  }

}