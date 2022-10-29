import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:tempoloco/model/user.dart';
import 'package:tempoloco/presentation/screen/profile/profile_state.dart';
import 'package:tempoloco/theme.dart';

class ProfileEditInfos extends StatefulWidget {
  const ProfileEditInfos({Key? key}) : super(key: key);

  @override
  State<ProfileEditInfos> createState() => _ProfileEditInfosState();
}

class _ProfileEditInfosState extends State<ProfileEditInfos> {
  final state = Get.find<ProfileState>();

  late TextEditingController usernameCtrl;
  late TextEditingController emailCtrl;

  User get user => state.userCtrl.user.value;

  @override
  void initState() {
    super.initState();
    usernameCtrl = TextEditingController(text: user.username);
    emailCtrl = TextEditingController(text: user.email);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: usernameCtrl,
            cursorColor: ktempoWhite,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.w600),
            onSubmitted: (input) async {
              final res =
                  await state.updateUsername(input.trim().toLowerCase());
              if (!res) usernameCtrl.text = user.username;
            },
            decoration: const InputDecoration(
              prefixIcon: SizedBox.shrink(),
              suffixIcon: Icon(Icons.edit, color: ktempoWhite),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: emailCtrl,
            cursorColor: ktempoWhite,
            textInputAction: TextInputAction.done,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
            onSubmitted: (input) async {
              final res = await state.updateEmail(input.trim());
              if (!res) emailCtrl.text = user.email;
            },
            decoration: const InputDecoration(
              prefixIcon: SizedBox.shrink(),
              suffixIcon: Icon(Icons.edit, color: ktempoWhite),
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
