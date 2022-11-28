import 'package:flutter/foundation.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:tempoloco/config.dart';

class Analytics {
  late Mixpanel mixpanel;

  Future<void> init() async {
    mixpanel = await Mixpanel.init(mixpanelToken, trackAutomaticEvents: true);
  }

  void identifyUser(String uid) {
    if (!kDebugMode) mixpanel.identify(uid);
  }

  void event(String name) {
    if (!kDebugMode) mixpanel.track(name);
  }

  void eventWithParams(String name, Map<String, dynamic> params) {
    if (!kDebugMode) mixpanel.track(name, properties: params);
  }

  Future<void> error(String strClass, String strFunction, dynamic text,
      {StackTrace? stack}) async {
    if (kDebugMode) return;
    final message = '-> [$strClass] $strFunction : ${text.toString()}';
    await Sentry.captureException(message, stackTrace: stack);
  }
}
