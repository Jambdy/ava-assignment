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
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute({List<_i3.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}
