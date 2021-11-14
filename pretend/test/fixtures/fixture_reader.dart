import 'dart:convert';
import 'dart:io';

dynamic fixture(String name) =>
    json.decode(File('test/fixtures/$name').readAsStringSync());