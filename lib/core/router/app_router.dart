import 'package:go_router/go_router.dart';
import 'package:track_shop_app/presentation/screens/category/new_category_screen.dart';
import 'package:track_shop_app/presentation/screens/collection/collection_detail_screen.dart';
import 'package:track_shop_app/presentation/screens/collection/new_collection_screen.dart';
import 'package:track_shop_app/presentation/screens/settings/settings_screen.dart';
import 'package:track_shop_app/presentation/screens/warehouse/new_warehouse_screen.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_detail_screen.dart';
import 'package:track_shop_app/presentation/widgets/bottom_navbar_scaffold.dart';
import 'package:track_shop_app/presentation/screens/warehouse/warehouse_screen.dart';
import 'package:track_shop_app/presentation/screens/collection/collection_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/warehouse',
  routes: [
    GoRoute(
      path: '/warehouse-details/:warehouseId',
      name: WarehouseDetailScreen.name,
      builder: (context, state) {
        final warehouseId = state.pathParameters['warehouseId'];
        return WarehouseDetailScreen(warehouseId: warehouseId!);
      },
    ),
    GoRoute(
      path: '/new-warehouse',
      name: NewWarehouseScreen.name,
      builder: (context, state) => const NewWarehouseScreen(),
    ),
    GoRoute(
      path: '/collection-details/:collectionId',
      name: CollectionDetailScreen.name,
      builder: (context, state) {
        final collectionId = state.pathParameters['collectionId'];
        return CollectionDetailScreen(collectionId: collectionId!);
      },
    ),
    GoRoute(
      path: '/new-category',
      name: NewCategoryScreen.name,
      builder: (context, state) => const NewCategoryScreen(),
    ),
    GoRoute(
      path: '/new-collection',
      name: NewCollectionScreen.name,
      builder: (context, state) => const NewCollectionScreen(),
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
              path: '/collection',
              name: CollectionScreen.name,
              builder: (context, state) => CollectionScreen(),
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
