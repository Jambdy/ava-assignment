import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'routing/router.dart';
import 'ui/core/themes/theme.dart';

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
      scrollBehavior: MyCustomScrollBehavior(),
      routerConfig: _appRouter.config(),
    );
  }
}

// This is a custom scroll behavior that allows mouse dragging on all platforms
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    ...super.dragDevices,
    PointerDeviceKind.mouse,
  };
}
