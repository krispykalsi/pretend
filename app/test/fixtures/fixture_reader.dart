import 'dart:convert';
import 'dart:io';

dynamic fixture(String name) =>
    json.decode(File('test/fixtures/$name').readAsStringSync());

String csvFixture(String name) =>
    File('test/fixtures/$name').readAsStringSync();
