import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempoloco/presentation/screen/settings/settings_state.dart';
import 'package:tempoloco/utils/constant.dart';

class SettingsLanguage extends StatelessWidget {
  const SettingsLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Get.find<SettingsState>();

    const flagSize = 45.0;
    const margin = 5.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Language"),
        SizedBox(
          height: 45,
          width: supportedLanguages.length * (flagSize + 2 * margin),
          child: ListView.builder(
            itemCount: supportedLanguages.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final language = supportedLanguages[index];

              return Obx(
                () => SettingsLanguageFlag(
                  language: language,
                  isSelected: state.language.value == language,
                  onTap: () => state.setLanguage(language),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SettingsLanguageFlag extends StatelessWidget {
  final String language;
  final void Function() onTap;
  final bool isSelected;

  const SettingsLanguageFlag({
    Key? key,
    required this.language,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 2,
          ),
        ),
        child: Image.asset("assets/images/$language.png", width: 40),
      ),
    );
  }
}
