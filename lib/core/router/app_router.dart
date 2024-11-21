import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/presentation/screens/catalogue/catalogue_detail_screen.dart';
import 'package:track_shop_app/presentation/screens/catalogue/new_catalogue_screen.dart';
import 'package:track_shop_app/presentation/screens/reminder/reminder_details.dart';
import 'package:track_shop_app/presentation/screens/reminder/reminder_screen.dart';
import 'package:track_shop_app/presentation/screens/settings/settings_screen.dart';
import 'package:track_shop_app/presentation/screens/user/login_screen.dart';
import 'package:track_shop_app/presentation/screens/user/register_screen.dart';
import 'package:track_shop_app/presentation/screens/warehouse/new_warehouse_screen.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_detail_screen.dart';
import 'package:track_shop_app/presentation/widgets/navbar_and_speeddial/bottom_navbar_scaffold.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_screen.dart';
import 'package:track_shop_app/presentation/screens/catalogue/catalogue_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: FirebaseAuth.instance.currentUser != null ? '/warehouse':'/login_screen',
  routes: [
    GoRoute(
      path: '/login_screen',
      name: LoginScreen.name,
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/register_screen',
      name: RegisterScreen.name,
      builder: (context, state) => RegisterScreen(),
    ),
    GoRoute(
      path: '/warehouse-details/:warehouseId',
      name: WarehouseDetailScreen.name,
      builder: (context, state) => WarehouseDetailScreen(
        warehouseId: state.pathParameters['warehouseId']!,
      ),
    ),
    GoRoute(
      path: '/new-warehouse',
      name: NewWarehouseScreen.name,
      builder: (context, state) => const NewWarehouseScreen(),
    ),
    GoRoute(
      path: '/reminder_screen',
      name: ReminderScreen.name,
      builder: (context, state) => const ReminderScreen(),
    ),
    GoRoute(
      path: '/reminder_details/:reminderId',
      name: ReminderDetailScreen.name,
      builder: (context, state) {
        final reminderId = state.pathParameters['reminderId'];
        return ReminderDetailScreen(reminderId: reminderId!);
      },
    )
,
    GoRoute(
      path: '/catalogue-details/:catalogueId',
      name: CatalogueDetailScreen.name,
      builder: (context, state) {
        final catalogueId = state.pathParameters['catalogueId'];
        return CatalogueDetailScreen(catalogueId: catalogueId!);
      },
    ),
    GoRoute(
      path: '/new-catalogue',
      name: NewCatalogueScreen.name,
      builder: (context, state) => const NewCatalogueScreen(),
    ),
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/warehouse',
              name: WarehouseScreen.name,
              builder: (context, state) => const WarehouseScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/catalogue',
              name: CatalogueScreen.name,
              builder: (context, state) => const CatalogueScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/settings',
              name: SettingsScreen.name,
              builder: (context, state) => const SettingsScreen(),
            ),
          ]),
        ])
  ],
);
