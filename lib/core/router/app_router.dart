import 'package:go_router/go_router.dart';
import 'package:track_shop_app/presentation/screens/category/new_category_screen.dart';
import 'package:track_shop_app/presentation/screens/catalogue/catalogue_detail_screen.dart';
import 'package:track_shop_app/presentation/screens/catalogue/new_catalogue_screen.dart';
import 'package:track_shop_app/presentation/screens/settings/settings_screen.dart';
import 'package:track_shop_app/presentation/screens/warehouse/new_warehouse_screen.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_detail_screen.dart';
import 'package:track_shop_app/presentation/widgets/bottom_navbar_scaffold.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_screen.dart';
import 'package:track_shop_app/presentation/screens/catalogue/catalogue_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/warehouse',
  routes: [
    GoRoute(
      path: '/warehouse-details/:warehouseId',
      name: WarehouseDetailScreen.name,
      //   return WarehouseDetailScreen(warehouseId: warehouseId!);
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
      path: '/catalogue-details/:catalogueId',
      name: CatalogueDetailScreen.name,
      builder: (context, state) {
        final catalogueId = state.pathParameters['catalogueId'];
        return CatalogueDetailScreen(catalogueId: catalogueId!);
      },
    ),
    GoRoute(
      path: '/new-category',
      name: NewCategoryScreen.name,
      builder: (context, state) => const NewCategoryScreen(),
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
              builder: (context, state) => WarehouseScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/catalogue',
              name: CatalogueScreen.name,
              builder: (context, state) => CatalogueScreen(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: '/settings',
              name: SettingsScreen.name,
              builder: (context, state) => const SettingsScreen(),
            ),
          ]),
          //StatefulShellBranch(routes: []),
        ])
  ],
);
