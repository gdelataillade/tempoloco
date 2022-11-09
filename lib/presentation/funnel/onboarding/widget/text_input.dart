import 'package:flutter/material.dart';
import 'package:tempoloco/theme.dart';

class OnboardingTextInput extends StatefulWidget {
  final String value;
  final Function(String) onSubmit;
  final bool isPassword;

  const OnboardingTextInput({
    Key? key,
    required this.value,
    required this.onSubmit,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<OnboardingTextInput> createState() => _OnboardingTextInputState();
}

class _OnboardingTextInputState extends State<OnboardingTextInput> {
  late TextEditingController controller;
  late bool hidePassword;

  @override
  void initState() {
    controller =
        TextEditingController(text: widget.isPassword ? '' : widget.value);
    hidePassword = !widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        autofocus: true,
        autocorrect: false,
        obscureText: widget.isPassword && !hidePassword,
        textInputAction:
            widget.isPassword ? TextInputAction.done : TextInputAction.next,
        controller: controller,
        textAlign: TextAlign.center,
        cursorColor: ktempoWhite,
        onSubmitted: (input) => widget.onSubmit(input.trim()),
        decoration: InputDecoration(
          prefixIcon: const SizedBox.shrink(),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    hidePassword ? Icons.visibility : Icons.visibility_off,
                    color: ktempoWhite,
                  ),
                  onPressed: () => setState(() => hidePassword = !hidePassword),
                )
              : const SizedBox.shrink(),
          focusedBorder: const UnderlineInputBorder(
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
