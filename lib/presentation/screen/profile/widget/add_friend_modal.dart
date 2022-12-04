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
    final size = MediaQuery.of(context).size.height / 4;

    return AlertDialog(
      elevation: 5.0,
      clipBehavior: Clip.hardEdge,
      backgroundColor: ktempoYellow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
      content: SizedBox(
        height: size,
        width: size,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'addFriend'.tr,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: ktempoPurple.withOpacity(0.8),
                      ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(left: 10),
                height: 38,
                width: 200,
                decoration: BoxDecoration(
                  color: ktempoWhite.withOpacity(0.9),
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
                    hintText: 'typeUsername'.tr,
                    hintStyle: TextStyle(color: ktempoPurple.withOpacity(0.8)),
                    border: InputBorder.none,
                  ),
                  onSubmitted: state.addFriendWithUsername,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: RawMaterialButton(
                  onPressed: () => state.addFriendWithUsername(controller.text),
                  child: Container(
                    height: 40,
                    width: 130,
                    decoration: BoxDecoration(
                      color: ktempoPurple.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        'Send invitation',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: ktempoYellow),
                      ),
                    ),
                  ),
                ),
              ),
              // MainButton(
              //   label: 'Send invitation',
              //   color: ktempoPurple,
              //   onTap: () => state.addFriendWithUsername(controller.text),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
