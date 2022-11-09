import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:multiavatar/multiavatar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:tempoloco/model/friend.dart';
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
    final username = userCtrl.user.value.username;
    final svgCode = multiavatar(username);

    svgRoot = await svg.fromSvgString(svgCode, username);
  }

  Future<void> loadFriendsAvatar() async {
    final userFriends = userCtrl.user.value.friends;

    for (int i = 0; i < userFriends.length; i++) {
      final svgCode = multiavatar(userFriends[i]);
      final root = await svg.fromSvgString(svgCode, userFriends[i]);

      friends.add(Friend(username: userFriends[i], svgRoot: root));
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

  // TODO: Avoid spaces ; also in onboarding
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

  Future<void> addFriendWithLink() async {
    final link = remoteLct.getString(linkStore);
    await Share.share(link);
  }

  Future<void> addFriendWithUsername(String username) async {
    String errorMessage = '';

    if (username == userCtrl.user.value.uid) {
      errorMessage = 'This is your username';
    }

    final res = await DB.usernameAlreadyExists(username);

    if (res) {
      await userCtrl.addFriend(username);
      Get.back();
      return;
    } else {
      errorMessage = 'Username not found';
    }

    if (errorMessage.isNotEmpty) {
      Helper.snack(
        'Error adding friend with username',
        errorMessage,
      );
    }
  }
}
