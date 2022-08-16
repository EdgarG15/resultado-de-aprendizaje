import 'dart:convert';
import 'package:http/http.dart';

Response bad = Response("Error", 408);

class GetRequest {
  Uri url = Uri.parse(
      'http://192.168.1.201/'); //IP GENERADA POR EL SERVIDOR DEL ESP32
  Future<String> getData() async {
    Response respuesta = await get(url).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return bad;
      },
    );
    String request = respuesta.body;
    if (respuesta.statusCode != 200) {
      return "Error: conexión fallida";
    }

    return request;
  }
}

class PostRequest {
  Uri url = Uri.parse('http://192.168.1.201/item');

  Future<String> postData(String param) async {
    Map<String, String> information = {"data": param};
    final data = jsonEncode(information);
    Response respuesta = await post(url, body: data).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return bad;
      },
    );
    String request = respuesta.body;
    if (respuesta.statusCode != 200) {
      return "Error: conexión fallida";
    }
    return request;
  }
}

class UpdateRequest {
  Future<String> updateData(String newParam, int index) async {
    Uri url = Uri.parse('http://192.168.1.201/item/$index');
    Map<String, String> information = {"data": newParam};
    final data = jsonEncode(information);
    Response respuesta = await patch(url, body: data).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return bad;
      },
    );
    String request = respuesta.body;
    if (respuesta.statusCode != 200) {
      return "Error: conexión fallida";
    }
    return request;
  }
}

class DeleteRequest {
  Future<String> deleteData(int index) async {
    Uri url = Uri.parse('http://192.168.1.201/item/$index');
    Response respuesta = await delete(url).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        return bad;
      },
    );
    String request = respuesta.body;
    if (respuesta.statusCode != 200) {
      return "Error: conexión fallida";
    }
    return request;
  }
}
