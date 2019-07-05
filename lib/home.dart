import 'package:flutter/material.dart';
import 'package:flutter_tencentmusician/chart-test.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/img_title.png', width: 200),
          backgroundColor: Colors.grey[50],
          elevation: 0,
        ),
        body: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: UserInfoCard(),
                ),
                Expanded(
                  child: BaseInfoCard(),
                ),
              ],
            ),
            IndexNumberCard(),
          ],
        ));
  }
}

class UserInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 1), color: Colors.black12, blurRadius: 18)
          ],
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text('音乐人',
                  style: TextStyle(color: Colors.black87, fontSize: 14)),
            ),
            Padding(
              padding: EdgeInsets.all(13),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://y.gtimg.cn/music/photo_new/T025R500x500M002000OoLnd3gaeKB.png'),
                radius: 50,
                backgroundColor: Colors.white,
              ),
            ),
            Text('黄祺', style: TextStyle(color: Colors.black, fontSize: 24)),
          ],
        ));
  }
}

class BaseInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 1), color: Colors.black12, blurRadius: 18)
          ],
          color: Colors.indigoAccent[700],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('昨日播放量', style: TextStyle(color: Colors.white, fontSize: 14)),
            Text(
              '518',
              style: TextStyle(color: Colors.white, fontSize: 34),
            ),
            Container(
              color: Colors.white10,
              height: 1,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            ),
            Text('总播放量', style: TextStyle(color: Colors.white, fontSize: 14)),
            Text(
              '35,683',
              style: TextStyle(color: Colors.white, fontSize: 34),
            ),
          ],
        ));
  }
}

class IndexNumberCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 1), color: Colors.black12, blurRadius: 18)
          ],
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: Text('昨日音乐人指数',
                  style: TextStyle(color: Colors.black87, fontSize: 14)),
            ),
            Padding(
              padding: EdgeInsets.all(13),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://y.gtimg.cn/music/photo_new/T025R500x500M002000OoLnd3gaeKB.png'),
                radius: 50,
                backgroundColor: Colors.white,
              ),
            ),
            Text('黄祺', style: TextStyle(color: Colors.black, fontSize: 24)),
          ],
        ));
  }
}
