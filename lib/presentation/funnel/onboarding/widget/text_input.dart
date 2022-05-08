import 'package:flutter/material.dart';
import 'package:tempoloco/presentation/theme/themes.dart';

class OnboardingTextInput extends StatelessWidget {
  final String value;
  final Function(String) onSubmit;

  const OnboardingTextInput({
    Key? key,
    required this.value,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: value);

    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        autofocus: true,
        textInputAction: TextInputAction.next,
        controller: controller,
        textAlign: TextAlign.center,
        cursorColor: ktempoWhite,
        onSubmitted: (input) => onSubmit(input.trim()),
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ktempoWhite),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ktempoWhite.withOpacity(0.7)),
          ),
        ),
      ),
    );
  }
}
