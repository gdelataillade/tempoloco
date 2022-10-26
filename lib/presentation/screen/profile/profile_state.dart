import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/service/database.dart';

class Friend {
  final String name;
  final DrawableRoot svgRoot;

  const Friend({required this.name, required this.svgRoot});
}

class ProfileState extends GetxController {
  late DrawableRoot svgRoot;

  List<Friend> friends = [];

  RxBool loaded = false.obs;

  final userCtrl = Get.find<UserController>();

  Future<void> loadUserAvatar() async {
    final id = userCtrl.user.value.uid;
    final svgCode = multiavatar(id);

    svgRoot = await svg.fromSvgString(svgCode, id);
  }

  Future<void> loadFriendsAvatar() async {
    final userFriends = userCtrl.user.value.friends;

    for (int i = 0; i < userFriends.length; i++) {
      final name = await DB.getFriendName(userFriends[i]);
      final svgCode = multiavatar(userFriends[i]);
      final root = await svg.fromSvgString(svgCode, userFriends[i]);

      friends.add(Friend(name: name, svgRoot: root));
    }
  }

  @override
  Future<void> onInit() async {
    await Future.wait([
      loadUserAvatar(),
      loadFriendsAvatar(),
    ]);

    loaded.value = true;
    super.onInit();
  }

  // TODO: Set shared link in remote config
  Future<void> addFriend() async {
    await Share.share("https://tempoloco.page.link/start");
  }
}
