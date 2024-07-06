// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i16;
import 'package:pocket_swap_fisi/domain/entities/chat/room.dart' as _i17;
import 'package:pocket_swap_fisi/domain/entities/transaction.dart' as _i18;
import 'package:pocket_swap_fisi/screen/auth/login_screen.dart' as _i7;
import 'package:pocket_swap_fisi/screen/chat/chat_list_screen.dart' as _i1;
import 'package:pocket_swap_fisi/screen/chat/chat_navigation_screen.dart'
    as _i2;
import 'package:pocket_swap_fisi/screen/chat/chat_screen.dart' as _i3;
import 'package:pocket_swap_fisi/screen/gift_shop/gift_shop_screen.dart' as _i5;
import 'package:pocket_swap_fisi/screen/history/transaction_history_screen.dart'
    as _i12;
import 'package:pocket_swap_fisi/screen/home/home_screen.dart' as _i6;
import 'package:pocket_swap_fisi/screen/maps/maps_screen.dart' as _i8;
import 'package:pocket_swap_fisi/screen/profile/edit_profile_screen.dart'
    as _i4;
import 'package:pocket_swap_fisi/screen/profile/navigator_edit_profile_screen.dart'
    as _i9;
import 'package:pocket_swap_fisi/screen/profile/profile_navigation_screen.dart'
    as _i10;
import 'package:pocket_swap_fisi/screen/profile/profile_screen.dart' as _i11;
import 'package:pocket_swap_fisi/screen/update/update_password.dart' as _i13;
import 'package:pocket_swap_fisi/screen/update/update_phone_number.dart'
    as _i14;

abstract class $AppRouter extends _i15.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i15.PageFactory> pagesMap = {
    ChatListRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.ChatListScreen(),
      );
    },
    ChatNavigationRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ChatNavigationScreen(),
      );
    },
    ChatRoute.name: (routeData) {
      final args = routeData.argsAs<ChatRouteArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.ChatScreen(
          key: args.key,
          room: args.room,
        ),
      );
    },
    EditProfileRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.EditProfileScreen(),
      );
    },
    GiftShopRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.GiftShopScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.LoginScreen(
          key: args.key,
          onResult: args.onResult,
        ),
      );
    },
    MapSample.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.MapSample(),
      );
    },
    NavigatorEditProfileRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.NavigatorEditProfileScreen(),
      );
    },
    ProfileNavigationRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.ProfileNavigationScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.ProfileScreen(),
      );
    },
    TransactionsList.name: (routeData) {
      final args = routeData.argsAs<TransactionsListArgs>();
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.TransactionsList(transactions: args.transactions),
      );
    },
    UpdatePassword.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.UpdatePassword(),
      );
    },
    UpdatePhoneNumber.name: (routeData) {
      return _i15.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.UpdatePhoneNumber(),
      );
    },
  };
}

/// generated route for
/// [_i1.ChatListScreen]
class ChatListRoute extends _i15.PageRouteInfo<void> {
  const ChatListRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ChatListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatListRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ChatNavigationScreen]
class ChatNavigationRoute extends _i15.PageRouteInfo<void> {
  const ChatNavigationRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ChatNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChatNavigationRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ChatScreen]
class ChatRoute extends _i15.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    _i16.Key? key,
    required _i17.Room room,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          ChatRoute.name,
          args: ChatRouteArgs(
            key: key,
            room: room,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static const _i15.PageInfo<ChatRouteArgs> page =
      _i15.PageInfo<ChatRouteArgs>(name);
}

class ChatRouteArgs {
  const ChatRouteArgs({
    this.key,
    required this.room,
  });

  final _i16.Key? key;

  final _i17.Room room;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, room: $room}';
  }
}

/// generated route for
/// [_i4.EditProfileScreen]
class EditProfileRoute extends _i15.PageRouteInfo<void> {
  const EditProfileRoute({List<_i15.PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i5.GiftShopScreen]
class GiftShopRoute extends _i15.PageRouteInfo<void> {
  const GiftShopRoute({List<_i15.PageRouteInfo>? children})
      : super(
          GiftShopRoute.name,
          initialChildren: children,
        );

  static const String name = 'GiftShopRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i7.LoginScreen]
class LoginRoute extends _i15.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i16.Key? key,
    required dynamic Function(bool?) onResult,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i15.PageInfo<LoginRouteArgs> page =
      _i15.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.onResult,
  });

  final _i16.Key? key;

  final dynamic Function(bool?) onResult;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [_i8.MapSample]
class MapSample extends _i15.PageRouteInfo<void> {
  const MapSample({List<_i15.PageRouteInfo>? children})
      : super(
          MapSample.name,
          initialChildren: children,
        );

  static const String name = 'MapSample';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i9.NavigatorEditProfileScreen]
class NavigatorEditProfileRoute extends _i15.PageRouteInfo<void> {
  const NavigatorEditProfileRoute({List<_i15.PageRouteInfo>? children})
      : super(
          NavigatorEditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'NavigatorEditProfileRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i10.ProfileNavigationScreen]
class ProfileNavigationRoute extends _i15.PageRouteInfo<void> {
  const ProfileNavigationRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ProfileNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileNavigationRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i11.ProfileScreen]
class ProfileRoute extends _i15.PageRouteInfo<void> {
  const ProfileRoute({List<_i15.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i12.TransactionsList]
class TransactionsList extends _i15.PageRouteInfo<TransactionsListArgs> {
  TransactionsList({
    required List<_i18.Transaction> transactions,
    List<_i15.PageRouteInfo>? children,
  }) : super(
          TransactionsList.name,
          args: TransactionsListArgs(transactions: transactions),
          initialChildren: children,
        );

  static const String name = 'TransactionsList';

  static const _i15.PageInfo<TransactionsListArgs> page =
      _i15.PageInfo<TransactionsListArgs>(name);
}

class TransactionsListArgs {
  const TransactionsListArgs({required this.transactions});

  final List<_i18.Transaction> transactions;

  @override
  String toString() {
    return 'TransactionsListArgs{transactions: $transactions}';
  }
}

/// generated route for
/// [_i13.UpdatePassword]
class UpdatePassword extends _i15.PageRouteInfo<void> {
  const UpdatePassword({List<_i15.PageRouteInfo>? children})
      : super(
          UpdatePassword.name,
          initialChildren: children,
        );

  static const String name = 'UpdatePassword';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}

/// generated route for
/// [_i14.UpdatePhoneNumber]
class UpdatePhoneNumber extends _i15.PageRouteInfo<void> {
  const UpdatePhoneNumber({List<_i15.PageRouteInfo>? children})
      : super(
          UpdatePhoneNumber.name,
          initialChildren: children,
        );

  static const String name = 'UpdatePhoneNumber';

  static const _i15.PageInfo<void> page = _i15.PageInfo<void>(name);
}
