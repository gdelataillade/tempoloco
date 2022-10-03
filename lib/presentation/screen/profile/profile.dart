import 'package:flutter/material.dart';
import 'package:tempoloco/presentation/common/widget/main_button.dart';
import 'package:tempoloco/service/auth.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Column(
        children: [
          Text(
            "Profile",
            style: Theme.of(context).textTheme.headline3,
          ),
          const MainButton(
            label: 'Sign out',
            onTap: Auth.signOut,
          ),
        ],
      ),
    );
  }
}
