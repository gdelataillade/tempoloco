import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/common/widget/main_button.dart';
import 'package:tempoloco/presentation/screen/profile/profile_state.dart';
import 'package:tempoloco/theme.dart';

class AddFriendModal extends StatelessWidget {
  const AddFriendModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final state = Get.find<ProfileState>();

    return AlertDialog(
      elevation: 5.0,
      clipBehavior: Clip.hardEdge,
      backgroundColor: ktempoDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Add friend", style: Theme.of(context).textTheme.titleLarge),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.only(left: 10),
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0.5,
                      blurRadius: 3,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                child: TextField(
                  autocorrect: false,
                  autofocus: true,
                  controller: controller,
                  cursorColor: ktempoPink,
                  style: const TextStyle(color: ktempoDark),
                  decoration: InputDecoration(
                    hintText: "Type username",
                    hintStyle: TextStyle(color: ktempoDark.withOpacity(0.6)),
                    border: InputBorder.none,
                  ),
                  onSubmitted: state.addFriendWithUsername,
                ),
              ),
              const Spacer(),
              Column(
                children: [
                  const Text("Or if your friend doesn't have tempoloco"),
                  MainButton(
                    onTap: state.addFriendWithLink,
                    label: 'Or send link',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
