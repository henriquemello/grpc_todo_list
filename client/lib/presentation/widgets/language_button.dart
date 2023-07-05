import 'package:flutter/material.dart';

class LanguageButton extends StatelessWidget {
  const LanguageButton({
    required this.onPressed,
    super.key,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    const fnLanguage='fr';
    return TextButton(
      onPressed: onPressed,
      child: Text(
        Localizations.localeOf(context).languageCode == fnLanguage ? "🇺🇸" : "🇫🇷",
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
