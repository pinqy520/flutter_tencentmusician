import 'package:flutter/material.dart';
import 'package:flutter_tencentmusician/home.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}


class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) { 
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Image.asset('assets/ts_logo.png', width: 200),
          FlatButton(
            child: const Text('立即登录',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              ),
            ),
            color: Colors.indigoAccent[700],
            padding: const EdgeInsets.fromLTRB(100, 15, 100, 15),
            onPressed: () {
              Navigator.push(context, 
                MaterialPageRoute(builder: (context) => HomePage())
              );
            },
          )
        ],
      ),
    );
  }

}