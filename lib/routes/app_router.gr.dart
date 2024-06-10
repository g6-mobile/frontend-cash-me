// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;
import 'package:pocket_swap_fisi/domain/entities/transaction.dart' as _i10;
import 'package:pocket_swap_fisi/screen/auth/login_screen.dart' as _i4;
import 'package:pocket_swap_fisi/screen/chat/chat_screen.dart' as _i1;
import 'package:pocket_swap_fisi/screen/gift_shop/gift_shop_screen.dart' as _i2;
import 'package:pocket_swap_fisi/screen/history/transaction_history_screen.dart'
    as _i7;
import 'package:pocket_swap_fisi/screen/home/home_screen.dart' as _i3;
import 'package:pocket_swap_fisi/screen/maps/maps_screen.dart' as _i5;
import 'package:pocket_swap_fisi/screen/profile/profile_screen.dart' as _i6;

abstract class $AppRouter extends _i8.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    ChatRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ChatScreen(),
      );
    },
    GiftShopRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.GiftShopScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.LoginScreen(
          key: args.key,
          onResult: args.onResult,
        ),
      );
    },
    MapSample.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MapSample(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.ProfileScreen(),
      );
    },
    TransactionsList.name: (routeData) {
      final args = routeData.argsAs<TransactionsListArgs>();
      return _i8.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.TransactionsList(transactions: args.transactions),
      );
    },
  };
}

/// generated route for
/// [_i1.ChatScreen]
class ChatRoute extends _i8.PageRouteInfo<void> {
  const ChatRoute({List<_i8.PageRouteInfo>? children})
      : super(
          ChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i2.GiftShopScreen]
class GiftShopRoute extends _i8.PageRouteInfo<void> {
  const GiftShopRoute({List<_i8.PageRouteInfo>? children})
      : super(
          GiftShopRoute.name,
          initialChildren: children,
        );

  static const String name = 'GiftShopRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute({List<_i8.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i8.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i9.Key? key,
    required dynamic Function(bool?) onResult,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i8.PageInfo<LoginRouteArgs> page =
      _i8.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.onResult,
  });

  final _i9.Key? key;

  final dynamic Function(bool?) onResult;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [_i5.MapSample]
class MapSample extends _i8.PageRouteInfo<void> {
  const MapSample({List<_i8.PageRouteInfo>? children})
      : super(
          MapSample.name,
          initialChildren: children,
        );

  static const String name = 'MapSample';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i6.ProfileScreen]
class ProfileRoute extends _i8.PageRouteInfo<void> {
  const ProfileRoute({List<_i8.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i8.PageInfo<void> page = _i8.PageInfo<void>(name);
}

/// generated route for
/// [_i7.TransactionsList]
class TransactionsList extends _i8.PageRouteInfo<TransactionsListArgs> {
  TransactionsList({
    required List<_i10.Transaction> transactions,
    List<_i8.PageRouteInfo>? children,
  }) : super(
          TransactionsList.name,
          args: TransactionsListArgs(transactions: transactions),
          initialChildren: children,
        );

  static const String name = 'TransactionsList';

  static const _i8.PageInfo<TransactionsListArgs> page =
      _i8.PageInfo<TransactionsListArgs>(name);
}

class TransactionsListArgs {
  const TransactionsListArgs({required this.transactions});

  final List<_i10.Transaction> transactions;

  @override
  String toString() {
    return 'TransactionsListArgs{transactions: $transactions}';
  }
}
