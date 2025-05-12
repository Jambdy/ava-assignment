// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:ava_assignment/ui/employment/widgets/employment_screen.dart'
    as _i1;
import 'package:ava_assignment/ui/home/widgets/home_screen.dart' as _i2;
import 'package:flutter/material.dart' as _i4;

/// generated route for
/// [_i1.EmploymentScreen]
class EmploymentRoute extends _i3.PageRouteInfo<void> {
  const EmploymentRoute({List<_i3.PageRouteInfo>? children})
    : super(EmploymentRoute.name, initialChildren: children);

  static const String name = 'EmploymentRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.EmploymentScreen();
    },
  );
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i3.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i4.Key? key,
    bool requestFeedback = false,
    List<_i3.PageRouteInfo>? children,
  }) : super(
         HomeRoute.name,
         args: HomeRouteArgs(key: key, requestFeedback: requestFeedback),
         initialChildren: children,
       );

  static const String name = 'HomeRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>(
        orElse: () => const HomeRouteArgs(),
      );
      return _i2.HomeScreen(
        key: args.key,
        requestFeedback: args.requestFeedback,
      );
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key, this.requestFeedback = false});

  final _i4.Key? key;

  final bool requestFeedback;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, requestFeedback: $requestFeedback}';
  }
}
