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
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 70),
      child: TextField(
        autofocus: true,
        autocorrect: false,
        obscureText: widget.isPassword && !hidePassword,
        textInputAction:
            widget.isPassword ? TextInputAction.done : TextInputAction.next,
        controller: controller,
        textAlign: TextAlign.center,
        cursorColor: ktempoYellow,
        onSubmitted: (input) => widget.onSubmit(input.trim()),
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: ktempoYellow),
        decoration: InputDecoration(
          prefixIcon: const SizedBox.shrink(),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    hidePassword ? Icons.visibility : Icons.visibility_off,
                    color: ktempoYellow,
                  ),
                  onPressed: () => setState(() => hidePassword = !hidePassword),
                )
              : const SizedBox.shrink(),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ktempoYellow),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ktempoYellow.withOpacity(0.7)),
          ),
        ),
      ),
    );
  }
}
