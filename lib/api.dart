import 'dart:async';
import 'dart:convert';
import 'dart:io';

class API {
  static final API _api = new API._internal();

  final client = new HttpClient();
  final Completer<String> _cookies = Completer<String>();
  TMData data = TMData();

  factory API() {
    return _api;
  }
  API._internal();

  void setCookies(String cookies) {
    _cookies.complete(cookies);
  }

  Future<dynamic> get(String path) async {
    final String cookies = await _cookies.future;
    final HttpClientRequest request =
        await client.get('y.tencentmusic.com', 80, path);
    request.headers.add(HttpHeaders.cookieHeader, cookies);
    final HttpClientResponse response = await request.close();
    final String result = await response.transform(utf8.decoder).join();
    Map<String, dynamic> json = jsonDecode(result);
    return json['data'];
  }

  Future<void> getUserHeadInfo() async {
    final info = await get('/v2/v2/user/getUserHeadInfo');
    data.name = info['name'];
    data.avatar = 'https:' + info['pic'];
  }

  Future<void> getUserSongInfo() async {
    final info = await get('/v2/v2/user/getUserIndexInfo');
    data.albumNumber = info['albumNumber'];
    data.songNumber = info['songNumber'];
  }

  Future<void> playnum() async {
    final info = await get('/v2/v2/datacenter/works/playnum?platform=all');
    data.yesterdayPlay = info['yesterday'];
    data.sumPlay = info['sum'];
  }

  Future<void> getUserAlbuminfo() async {
    final info = await get(
        '/v2/v2/album/getUserAlbuminfo?pageNo=1&pageSize=500&status=0');
    // final List<Map<String, dynamic>> content = List.from(info['content']);
    data.albums = List.from(info['content'].map(itemToAlbum));
  }

  Future<void> getUserIndex() async {
    final info = await get('/v2/v2/datacenter/index');
    data.yesterdayIndex = info['yesterdayIndex'];
    data.index = info['index'];
  }

  Future<void> getIndexData() async {
    final info = await get('/v2/v2/datacenter/index/day?day=30');
    // final List<Map<String, dynamic>> content = List.from(info['content']);
    data.indexes = List.from(info.map(itemToIndex));
  }
}

AlbumData itemToAlbum(dynamic item) {
  return AlbumData(item['name'], 'https:' + item['pic']);
}

IndexItem itemToIndex(dynamic item) {
  return IndexItem(item['day'], item['index']);
}

class TMData {
  String name = '';
  String avatar = '';
  int albumNumber = 0;
  int songNumber = 0;
  int yesterdayPlay = 0;
  int sumPlay = 0;
  double yesterdayIndex = 0;
  double index = 0;
  List<AlbumData> albums = [];
  List<IndexItem> indexes = [];
}

class AlbumData {
  AlbumData(this.name, this.cover) {}

  final String cover;
  final String name;
}

class IndexItem {
  IndexItem(this.date, this.index) {}
  final String date;
  final double index;
}
