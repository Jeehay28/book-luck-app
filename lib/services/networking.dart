import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url, {this.body});

  final String url;
  final Object? body;

  Future getData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      }
    } catch (err) {
      print('NetworkHelper POST Exception: $err');
      return null;
    }
  }

  Future postData() async {
    try {
      http.Response response;

      if (body != null) {
        response = await http.post(Uri.parse(url),
            headers: {
              'Content-Type': 'application/json; charset=utf-8',
            },
            body: jsonEncode(body));
      } else {
        response = await http.post(Uri.parse(url), headers: {
          'Content-Type': 'application/json; charset=utf-8',
        });
      }

      if (response.statusCode == 200 || response.statusCode == 400) {
        final contentType = response.headers['content-type'];
        if (contentType != null && contentType.contains('application/json')) {
          return jsonDecode(response.body);
        } else {
          return response.body; // just a plain string
        }
      }
    } catch (err) {
      print('NetworkHelper POST Exception: $err');
      return null;
    }
  }
}
