// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:pocket_swap_fisi/domain/entities/transaction.dart' as _i14;
import 'package:pocket_swap_fisi/screen/auth/login_screen.dart' as _i7;
import 'package:pocket_swap_fisi/screen/chat/chat_list_screen.dart' as _i1;
import 'package:pocket_swap_fisi/screen/chat/chat_navigation_screen.dart'
    as _i2;
import 'package:pocket_swap_fisi/screen/chat/chat_screen.dart' as _i3;
import 'package:pocket_swap_fisi/screen/gift_shop/gift_shop_screen.dart' as _i5;
import 'package:pocket_swap_fisi/screen/history/transaction_history_screen.dart'
    as _i11;
import 'package:pocket_swap_fisi/screen/home/home_screen.dart' as _i6;
import 'package:pocket_swap_fisi/screen/maps/maps_screen.dart' as _i8;
import 'package:pocket_swap_fisi/screen/profile/edit_profile_screen.dart'
    as _i4;
import 'package:pocket_swap_fisi/screen/profile/profile_navigation_screen.dart'
    as _i9;
import 'package:pocket_swap_fisi/screen/profile/profile_screen.dart' as _i10;

abstract class $AppRouter extends _i12.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i12.PageFactory> pagesMap = {
    ChatListRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ChatListScreen(),
      );
    },
    ChatNavigationRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ChatNavigationScreen(),
      );
    },
    ChatRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ChatScreen(),
      );
    },
    EditProfileRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.EditProfileScreen(),
      );
    },
    GiftShopRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.GiftShopScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.LoginScreen(
          key: args.key,
          onResult: args.onResult,
        ),
      );
    },
    MapSample.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.MapSample(),
      );
    },
    ProfileNavigationRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.ProfileNavigationScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.ProfileScreen(),
      );
    },
    TransactionsList.name: (routeData) {
      final args = routeData.argsAs<TransactionsListArgs>();
      return _i12.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.TransactionsList(transactions: args.transactions),
      );
    },
  };
}

/// generated route for
/// [_i1.ChatListScreen]
class ChatListRoute extends _i12.PageRouteInfo<void> {
  const ChatListRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ChatListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatListRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ChatNavigationScreen]
class ChatNavigationRoute extends _i12.PageRouteInfo<void> {
  const ChatNavigationRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ChatNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatNavigationRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ChatScreen]
class ChatRoute extends _i12.PageRouteInfo<void> {
  const ChatRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i4.EditProfileScreen]
class EditProfileRoute extends _i12.PageRouteInfo<void> {
  const EditProfileRoute({List<_i12.PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i5.GiftShopScreen]
class GiftShopRoute extends _i12.PageRouteInfo<void> {
  const GiftShopRoute({List<_i12.PageRouteInfo>? children})
      : super(
          GiftShopRoute.name,
          initialChildren: children,
        );

  static const String name = 'GiftShopRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i7.LoginScreen]
class LoginRoute extends _i12.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i13.Key? key,
    required dynamic Function(bool?) onResult,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i12.PageInfo<LoginRouteArgs> page =
      _i12.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.onResult,
  });

  final _i13.Key? key;

  final dynamic Function(bool?) onResult;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [_i8.MapSample]
class MapSample extends _i12.PageRouteInfo<void> {
  const MapSample({List<_i12.PageRouteInfo>? children})
      : super(
          MapSample.name,
          initialChildren: children,
        );

  static const String name = 'MapSample';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i9.ProfileNavigationScreen]
class ProfileNavigationRoute extends _i12.PageRouteInfo<void> {
  const ProfileNavigationRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ProfileNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileNavigationRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ProfileScreen]
class ProfileRoute extends _i12.PageRouteInfo<void> {
  const ProfileRoute({List<_i12.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i12.PageInfo<void> page = _i12.PageInfo<void>(name);
}

/// generated route for
/// [_i11.TransactionsList]
class TransactionsList extends _i12.PageRouteInfo<TransactionsListArgs> {
  TransactionsList({
    required List<_i14.Transaction> transactions,
    List<_i12.PageRouteInfo>? children,
  }) : super(
          TransactionsList.name,
          args: TransactionsListArgs(transactions: transactions),
          initialChildren: children,
        );

  static const String name = 'TransactionsList';

  static const _i12.PageInfo<TransactionsListArgs> page =
      _i12.PageInfo<TransactionsListArgs>(name);
}

class TransactionsListArgs {
  const TransactionsListArgs({required this.transactions});

  final List<_i14.Transaction> transactions;

  @override
  String toString() {
    return 'TransactionsListArgs{transactions: $transactions}';
  }
}
