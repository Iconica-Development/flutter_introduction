import "package:flutter/material.dart";
import "package:flutter_introduction/src/config/introduction_theme.dart";

class Button extends StatelessWidget {
  const Button({
    required this.text,
    required this.onPressed,
    required this.showButton,
    required this.introductionTheme,
    super.key,
  });
  final String text;
  final Function() onPressed;
  final bool showButton;
  final IntroductionTheme introductionTheme;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Expanded(
      child: showButton
          ? FilledButton(
              style: ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: WidgetStateProperty.all(const Size(160, 32)),
                backgroundColor: WidgetStateProperty.all(
                  introductionTheme.buttonBackgroundColor,
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    side: BorderSide(
                      color: introductionTheme.buttonBorderColor,
                      width: 1,
                    ),
                  ),
                ),
              ),
              onPressed: onPressed,
              child: Text(
                text,
                style: introductionTheme.buttonTextStyle ??
                    theme.textTheme.bodyMedium,
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
