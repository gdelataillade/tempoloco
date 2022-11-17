import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:tempoloco/config.dart';

class Analytics {
  late Mixpanel mixpanel;

  Future<void> init() async {
    mixpanel = await Mixpanel.init(mixpanelToken, trackAutomaticEvents: true);
  }

  void event(String name) => mixpanel.track(name);

  void eventWithParams(String name, Map<String, dynamic> params) =>
      mixpanel.track(name, properties: params);
}
