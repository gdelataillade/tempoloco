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
  List<Friend> friends = [];

  RxList friendRequests = [].obs;

  RxBool friendsLoaded = false.obs;

  final userCtrl = Get.find<UserController>();
  final avatarSvgRoot = Get.arguments as DrawableRoot;

  Future<void> loadFriendsAvatar() async {
    final userFriends = userCtrl.user.value.friends;

    friends.clear();

    for (int i = 0; i < userFriends.length; i++) {
      final svgCode = multiavatar(userFriends[i], trBackground: true);
      final root = await svg.fromSvgString(svgCode, userFriends[i]);

      friends.add(
        Friend(id: userFriends[i], username: userFriends[i], svgRoot: root),
      );
    }
    friendsLoaded.value = true;
  }

  @override
  Future<void> onReady() async {
    await loadFriendsAvatar();
    friendRequests.value = userCtrl.user.value.friendRequests;
    super.onReady();
  }

  // TODO: Update username in friend's model
  Future<bool> updateUsername(String username) async {
    if (username == userCtrl.user.value.username) return false;

    final res = await DB.usernameAlreadyExists(username);

    if (!res) {
      await Auth.updateUsername(username);
      await DB.updateUser({'username': username});

      Helper.snack(
        'username_updated'.tr,
        'new_username'.trParams({'username': username}),
        error: false,
      );
    } else {
      Helper.snack('username_update_error'.tr, 'username_already_taken'.tr);
    }
    return !res;
  }

  Future<bool> updateEmail(String email) async {
    if (email == userCtrl.user.value.email) return false;

    final res = await Auth.updateEmail(email);

    if (res) {
      await DB.updateUser({'email': email});
      Helper.snack(
        'email_updated'.tr,
        'new_email'.trParams({'email': email}),
        error: false,
      );
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

    if (username.isEmpty) return;
    if (username == userCtrl.user.value.uid) {
      errorMessage = 'error_username_is_you'.tr;
    } else if (userCtrl.user.value.friends.contains(username)) {
      errorMessage = 'error_already_friend'.trParams({'username': username});
    }

    final res = await DB.usernameAlreadyExists(username);

    if (res) {
      await userCtrl.sendFriendRequest(username);
      Get.back();
      await loadFriendsAvatar();
      Helper.snack(
        'invitation_sent'.tr,
        'invitation_username'.trParams({'username': username}),
        error: false,
      );
      return;
    } else {
      errorMessage = 'username_not_found'.tr;
    }

    if (errorMessage.isNotEmpty) {
      Helper.snack(
        'error_adding_friend'.tr,
        errorMessage,
      );
    }
  }

  Future<void> friendRequest(String username, bool accept) async {
    await userCtrl.handleFriendRequest(username, accept);
    friendRequests.value = userCtrl.user.value.friendRequests;

    if (accept) {
      friendsLoaded.value = false;
      await loadFriendsAvatar();
      friendsLoaded.value = true;
    }
  }
}
