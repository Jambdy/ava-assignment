import 'package:ava_assignment/router.dart';
import 'package:ava_assignment/ui/core/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: App()));
}

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Ava Assignment',
      theme: AppTheme.lightTheme,
      routerConfig: _appRouter.config(),
    );
  }
}
