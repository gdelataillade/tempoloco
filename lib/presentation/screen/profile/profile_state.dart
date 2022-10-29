import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/service/auth.dart';
import 'package:tempoloco/service/database.dart';
import 'package:tempoloco/service/locator.dart';
import 'package:tempoloco/service/remote.dart';
import 'package:tempoloco/utils/helper.dart';

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
      final username = await DB.getFriendUsername(userFriends[i]);
      final svgCode = multiavatar(userFriends[i]);
      final root = await svg.fromSvgString(svgCode, userFriends[i]);

      friends.add(Friend(username: username, svgRoot: root));
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

  Future<bool> updateUsername(String username) async {
    if (username == userCtrl.user.value.username) return false;

    final res = await DB.usernameAlreadyExists(username);

    if (!res) {
      await Auth.updateUsername(username);
      await DB.updateUser({"username": username});
      Helper.snack('Username updated', 'Your username is now $username');
      return true;
    } else {
      Helper.snack(
          'Error updating username', 'This username is already taken.');
      return false;
    }
  }

  Future<bool> updateEmail(String email) async {
    if (email == userCtrl.user.value.email) return false;

    final res = await Auth.updateEmail(email);

    if (res) {
      await DB.updateUser({"email": email});
      Helper.snack('Email updated', 'Your email is now $email');
      return true;
    }
    return false;
  }

  Future<void> addFriend() async {
    final link = remoteLct.getString(linkStore);
    await Share.share(link);
  }
}

class Friend {
  final String username;
  final DrawableRoot svgRoot;

  const Friend({required this.username, required this.svgRoot});
}
