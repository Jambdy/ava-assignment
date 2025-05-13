import 'package:flutter/material.dart';

import '../themes/theme.dart';

class AvaTitle extends StatelessWidget {
  const AvaTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 20),
      child: Text(title, style: AppTheme.title),
    );
  }
}
