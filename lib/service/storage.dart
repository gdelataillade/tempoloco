import 'dart:io';
import 'package:hive/hive.dart';

const hiveBoxes = <String>[
  "credentials",
];

class Storage {
  static Future<void> init() async {
    Hive.init(Directory.current.path);

    for (final box in hiveBoxes) {
      await Hive.openBox(box);
    }
  }

  static Future<void> writeData(String box, String key, String value) async {
    assert(hiveBoxes.contains(box),
        "Storage:writeData => Box $box do not exists.");
    Hive.box(box).put(key, value);
  }

  static dynamic readData(String box, String key) {
    assert(hiveBoxes.contains(box),
        "Storage:writeData => Box $box do not exists.");
    return Hive.box(box).get(key);
  }

  static Future<void> deleteData(String box, String key) async {
    assert(hiveBoxes.contains(box),
        "Storage:writeData => Box $box do not exists.");
    await Hive.box(box).delete(key);
  }
}
