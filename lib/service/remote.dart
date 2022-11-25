import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

const linkStore = 'link_store';

class Remote {
  final FirebaseRemoteConfig remote = FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await remote.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
    await remote.setDefaults(
      const {
        linkStore: 'https://tempo-dingo-db.web.app',
      },
    );
    await remote.fetchAndActivate();
    debugPrint('===> [RemoteConfig] Initialized');
  }

  int getInt(String str) {
    final res = remote.getInt(str);
    debugPrint('===> [RemoteConfig] getInt $str: $res');
    return res;
  }

  bool getBool(String str) {
    final res = remote.getBool(str);
    debugPrint('===> [RemoteConfig] getBool $str: $res');
    return res;
  }

  String getString(String str) {
    final res = remote.getString(str);
    debugPrint('===> [RemoteConfig] getString $str: $res');
    return res;
  }
}
