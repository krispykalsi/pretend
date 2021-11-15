import 'package:hive/hive.dart';
import 'package:core/error.dart';

abstract class HiveDataSource {
  final HiveInterface hive;

  HiveDataSource(this.hive);

  Future<Box> openBox(String type) async {
    try {
      final box = await hive.openBox(type);
      return box;
    } catch (e) {
      throw CacheException();
    }
  }
}