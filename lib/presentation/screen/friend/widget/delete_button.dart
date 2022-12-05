import 'package:flutter/material.dart';
import 'package:tempoloco/theme.dart';

class FriendScreenDeleteButton extends StatelessWidget {
  const FriendScreenDeleteButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Delete friend',
          style: TextStyle(color: ktempoRed.withOpacity(0.7)),
        ),
      ),
    );
  }
}
