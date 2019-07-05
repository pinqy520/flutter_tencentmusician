import 'package:flutter/material.dart';

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
          title: Text('黄祺'),
        ),
        body: GridView.count(
          // primary: false,
          padding: const EdgeInsets.all(10.0),
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          crossAxisCount: 2,
          children: <Widget>[
            Card(
              elevation: 16,
              child: Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://y.gtimg.cn/music/photo_new/T025R500x500M002000OoLnd3gaeKB.png'),
                  radius: 50,
                ),
              ),
            ),
            Card(elevation: 16, child: Text('test')),
            Card(elevation: 16, child: Text('test')),
            Card(elevation: 16, child: Text('test')),
          ],
        ));
  }
}
