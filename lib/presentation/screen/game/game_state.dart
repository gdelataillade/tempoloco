import 'package:get/get.dart';
import 'package:spotify/spotify.dart';

class GameState extends GetxController {
  Track track = Get.arguments as Track;

  @override
  void onInit() {
    super.onInit();
  }
}
