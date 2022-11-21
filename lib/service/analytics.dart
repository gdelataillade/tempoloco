import 'package:flutter/foundation.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:tempoloco/config.dart';

class Analytics {
  late Mixpanel mixpanel;

  Future<void> init() async {
    mixpanel = await Mixpanel.init(mixpanelToken, trackAutomaticEvents: true);
  }

  void event(String name) => mixpanel.track(name);

  void eventWithParams(String name, Map<String, dynamic> params) =>
      mixpanel.track(name, properties: params);

  void error(String strClass, String strFunction, dynamic text,
      {StackTrace? stack}) {
    if (kDebugMode) return;
    final message = "-> [$strClass] $strFunction : ${text.toString()}";
    Sentry.captureException(message, stackTrace: stack);
  }
}
