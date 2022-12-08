import 'package:flutter/material.dart';
import 'package:tempoloco/presentation/common/widget/main_button.dart';
import 'package:tempoloco/theme.dart';

class FriendScreenDeleteButton extends StatelessWidget {
  const FriendScreenDeleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Delete friend method + translation
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: MainButton(
        onTap: () {},
        color: ktempoRed.withOpacity(0.8),
        label: 'Delete friend',
      ),
    );
  }
}
