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

  Future<Map<String, dynamic>> get(String path) async {
    final String cookies = await _cookies.future;
    final HttpClientRequest request =
        await client.get('y.tencentmusic.com', 80, path);
    request.headers.add(HttpHeaders.cookieHeader, cookies);
    final HttpClientResponse response = await request.close();
    final String result = await response.transform(utf8.decoder).join();
    Map<String, dynamic> json = jsonDecode(result);
    return json['data'];
  }

  void getUserHeadInfo() async {
    final info = await get('/v2/v2/user/getUserHeadInfo');
    data.name = info['name'];
    data.avatar = 'https:' + info['pic'];
  }

  void getUserIndexInfo() async {
    final info = await get('/v2/v2/user/getUserIndexInfo');
    data.albumNumber = info['albumNumber'];
    data.songNumber = info['songNumber'];
  }

  void playnum() async {
    final info = await get('/v2/v2/datacenter/works/playnum?platform=all');
    data.yesterdayPlay = info['yesterday'];
    data.sumPlay = info['sum'];
  }
}

class TMData {
  String name = '';
  String avatar = '';
  int albumNumber = 0;
  int songNumber = 0;
  int yesterdayPlay = 0;
  int sumPlay = 0;
}
