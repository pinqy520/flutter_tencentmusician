import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  AboutPage({Key key}) : super(key: key);

  @override
  _AboutPageState createState() {
    return _AboutPageState();
  }
}

const myMusic =
    'https://i.y.qq.com/n2/m/share/details/singer.html?singerMid=003jVZy62mvtpJ';

class _AboutPageState extends State<AboutPage> {
  _launchURL() {
    launch(myMusic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(20, 50, 20, 20),
                padding: EdgeInsets.fromLTRB(15, 55, 15, 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 18)
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Text('关于此应用',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        '我是黄祺 - 开发者、设计师、独立音乐人。\n\n腾讯音乐人的网站每次都得在电脑上登录太麻烦了，所以就萌生了要做一个移动版的念头。前期调研了下模拟登录的可行性，发现没什么大问题，就开始做了。\n\n花了两天时间设计并使用Flutter构建这个跨平台的应用，有问题请提ISSUE，欢迎PR。\n\n最后，希望大家能关注和喜欢我的音乐，谢谢！',
                        style: TextStyle(fontSize: 14, height: 1.1),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                './assets/about_logo.png',
                width: 100,
              )
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _launchURL,
        tooltip: '我的音乐',
        backgroundColor: Colors.black87,
        child: Icon(Icons.music_note),
      ),
    );
  }
}
