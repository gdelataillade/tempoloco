import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tempoloco/controller/user_controller.dart';
import 'package:wiredash/wiredash.dart';

class WiredashFeedbackButton extends StatefulWidget {
  const WiredashFeedbackButton({Key? key}) : super(key: key);

  @override
  State<WiredashFeedbackButton> createState() => _WiredashFeedbackStateButton();
}

class _WiredashFeedbackStateButton extends State<WiredashFeedbackButton> {
  void setWiredashParams(BuildContext context, PackageInfo infos) async {
    final user = Get.find<UserController>().user.value;

    Wiredash.of(context).setUserProperties(
      userEmail: user.email,
      userId: user.uid,
    );
    Wiredash.of(context).setBuildProperties(
      buildNumber: infos.buildNumber,
      buildVersion: infos.version,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Fix setState called during build
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          setWiredashParams(context, snapshot.data!);
          return TextButton(
            onPressed: () =>
                Wiredash.of(context).show(inheritMaterialTheme: true),
            child: Text('giveFeedback'.tr),
          );
        }
        return const SizedBox();
      },
    );
  }
}
