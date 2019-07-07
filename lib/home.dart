import 'package:flutter/material.dart';
import 'package:flutter_tencentmusician/api.dart';
import 'package:flutter_tencentmusician/index-chart.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    await Future.wait([
      API().getUserSongInfo(),
      API().playnum(),
      API().getUserAlbuminfo(),
      API().getIndexData(),
      API().getUserIndex()
    ]);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(10, 30, 20, 20),
            child: Image.asset('assets/img_title.png', width: 200),
          ),
          Container(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.from(API().data.albums.map(musicItem)),
            ),
          ),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: MusicInfoCard(),
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        backgroundColor: Colors.black87,
        child: Icon(Icons.music_note),
      ),
    );
  }
}

class UserInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 190,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
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
              padding: EdgeInsets.all(12),
              child: CircleAvatar(
                backgroundImage: NetworkImage(API().data.avatar),
                radius: 45,
                backgroundColor: Colors.white,
              ),
            ),
            Text(API().data.name,
                style: TextStyle(color: Colors.black, fontSize: 24)),
          ],
        ));
  }
}

class BaseInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 190,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
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
            Container(height: 10),
            Text(
              API().data.yesterdayPlay.toString(),
              style: TextStyle(color: Colors.white, fontSize: 34),
            ),
            Container(
              color: Colors.white10,
              height: 1,
              margin: EdgeInsets.fromLTRB(0, 11, 0, 11),
            ),
            Text('总播放量', style: TextStyle(color: Colors.white, fontSize: 14)),
            Container(height: 10),
            Text(
              API().data.sumPlay.toString(),
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
            Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('${API().data.yesterdayIndex} ',
                          style: TextStyle(
                              fontSize: 34, fontWeight: FontWeight.bold)),
                      Text('平均 ${API().data.index}',
                          style: TextStyle(fontSize: 12, color: Colors.black54))
                    ],
                  ),
                ),
                IndexChart()
              ],
            )
          ],
        ));
  }
}

class MusicInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 190,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 1), color: Colors.black12, blurRadius: 18)
          ],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('专辑', style: TextStyle(color: Colors.black87, fontSize: 14)),
            Container(height: 10),
            Text(
              API().data.albumNumber.toString(),
              style: TextStyle(color: Colors.black, fontSize: 34),
            ),
            Container(
              color: Colors.black12,
              height: 1,
              margin: EdgeInsets.fromLTRB(0, 11, 0, 11),
            ),
            Text('歌曲', style: TextStyle(color: Colors.black87, fontSize: 14)),
            Container(height: 10),
            Text(
              API().data.songNumber.toString(),
              style: TextStyle(color: Colors.black, fontSize: 34),
            ),
          ],
        ));
  }
}

Widget musicItem(AlbumData data) {
  return Container(
    width: 90,
    height: 90,
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      image: DecorationImage(image: NetworkImage(data.cover)),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(offset: Offset(0, 1), color: Colors.black12, blurRadius: 5)
      ],
      color: Colors.white,
    ),
  );
}
