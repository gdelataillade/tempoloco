import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

const hiveBoxes = <String>[
  "credentials", // email, password
];

class Storage {
  static Future<void> init() async {
    Directory directory =
        await path_provider.getApplicationDocumentsDirectory();

    Hive.init(directory.path);

    for (final box in hiveBoxes) {
      await Hive.openBox(box);
    }
  }

  static Future<void> writeData(String box, String key, String value) async {
    assert(hiveBoxes.contains(box),
        "Storage:writeData => Box $box do not exists.");
    Hive.box(box).put(key, value);
    debugPrint("[Storage] write in box $box: $key => $value");
  }

  static dynamic readData(String box, String key) {
    assert(hiveBoxes.contains(box),
        "Storage:writeData => Box $box do not exists.");
    final res = Hive.box(box).get(key);
    debugPrint("[Storage] read in box $box: $key => $res");
    return res;
  }

  static Future<void> deleteData(String box, String key) async {
    assert(hiveBoxes.contains(box),
        "Storage:writeData => Box $box do not exists.");
    await Hive.box(box).delete(key);
    debugPrint("[Storage] delete in box $box: $key");
  }

  static Future<void> clearBox(String box) async {
    assert(hiveBoxes.contains(box),
        "Storage:writeData => Box $box do not exists.");
    await Hive.box(box).clear();
    debugPrint("[Storage] clear box all entries of box: $box");
  }
}