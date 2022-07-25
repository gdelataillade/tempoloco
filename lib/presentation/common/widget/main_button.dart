import 'package:flutter/material.dart';
import 'package:tempoloco/theme.dart';

class MainButton extends StatelessWidget {
  final String label;
  final bool disable;
  final Function() onTap;

  const MainButton({
    Key? key,
    this.label = 'Continue',
    this.disable = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: AnimatedOpacity(
          opacity: disable ? 0.3 : 1,
          duration: const Duration(milliseconds: 200),
          child: RawMaterialButton(
            onPressed: onTap,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ktempoWhite,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: ktempoDark),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
