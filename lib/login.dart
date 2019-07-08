import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_tencentmusician/api.dart';
import 'package:flutter_tencentmusician/home.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const LOGIN_URL =
    'https://ui.ptlogin2.qq.com/cgi-bin/login?pt_no_auth=1&pt_wxtest=1&pt_no_onekey=0&appid=1600001280&daid=656&style=9&hln_css=https://y.gtimg.cn/music/tmejs/other/loginlogo.png&s_url=https%3A%2F%2Fy.tencentmusic.com%2Flogin_close.html';
const LOGIN_DONE_URL = 'https://y.tencentmusic.com/login_close.html';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  final client = new HttpClient();
  final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    this.auth();
  }

  void auth() {
    storage.read(key: 'cookies').then(login);
  }

  void login(String cookies) async {
    API().setCookies(cookies);
    print(cookies);
    try {
      await API().getUserHeadInfo();
    } catch (e, r) {
      print(e);
    }
    flutterWebViewPlugin.close();
    if (API().isLogin) {
      storage.write(key: 'cookies', value: cookies);
      flutterWebViewPlugin.dispose();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {}
  }

  void toLogin() {
    flutterWebViewPlugin.launch(LOGIN_URL);
    flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      // print('onStateChanged: ${state.type} ${state.url}');
      if (state.type == WebViewState.finishLoad &&
          state.url.startsWith(LOGIN_DONE_URL)) {
        flutterWebViewPlugin.getAllCookies(LOGIN_DONE_URL).then(login);
      }
    });
    // Navigator.pushReplacement(
    //     context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Image.asset('assets/ts_logo.png', width: 260),
          FlatButton(
            child: const Text(
              '登入查看数据',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            color: Colors.indigoAccent[700],
            padding: const EdgeInsets.fromLTRB(90, 15, 90, 15),
            onPressed: toLogin,
          )
        ],
      ),
    );
  }
}
