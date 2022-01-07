import 'dart:convert';

abstract class JsonCoderContract {
  Future<dynamic> decode(String encoded);
  Future<String> encode(Object? data);
}

class JsonCoder implements JsonCoderContract {
  @override
  Future decode(String encoded) async {
    return jsonDecode(encoded);
  }

  @override
  Future<String> encode(Object? data) async {
    return jsonEncode(data);
  }
}