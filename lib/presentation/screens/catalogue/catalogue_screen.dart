import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:track_shop_app/presentation/screens/category/new_category_screen.dart';
import 'package:track_shop_app/presentation/screens/catalogue/catalogue_detail_screen.dart';
import 'package:track_shop_app/core/data/catalogue_datasource.dart';
import 'package:track_shop_app/entities/catalogue.dart';
import 'package:track_shop_app/presentation/screens/catalogue/new_catalogue_screen.dart';
import 'package:track_shop_app/presentation/widgets/dialogs/element/new_element_dialog.dart';
import 'package:track_shop_app/presentation/widgets/items/catalogue_item.dart';

class CatalogueScreen extends StatelessWidget {
  static const String name = 'catalogue_screen';
  final isDialOpen = ValueNotifier(false);
  final List<Catalogue> catalogues = catalogueList;

  CatalogueScreen({super.key});

  @override
  // ignore: deprecated_member_use
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          if (isDialOpen.value) {
            isDialOpen.value = false;
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Catalogue'),
          ),
          floatingActionButton: SpeedDial(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            icon: Icons.add,
            overlayColor: Colors.black,
            overlayOpacity: 0.4,
            openCloseDial: isDialOpen,
            spacing: 12,
            spaceBetweenChildren: 12,
            children: [
              SpeedDialChild(
                child: const Icon(Icons.list_alt),
                label: 'New Catalogue',
                onTap: () => context.goNamed(NewCatalogueScreen.name),
              ),
              SpeedDialChild(
                child: const Icon(Icons.category),
                label: 'Add Category',
                onTap: () => context.goNamed(NewCategoryScreen.name),
              ),
              SpeedDialChild(
                child: const Icon(Icons.dashboard_customize),
                label: 'Add Item',
                onTap: () {
                  showCreateElementDialog(context);
                },
              ),
            ],
          ),
          body: const _CataloguesView(),
        ),
      );
}

class _CataloguesView extends StatelessWidget {
  const _CataloguesView();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: catalogueList.length,
      itemBuilder: (context, index) {
        final catalogue = catalogueList[index];
        return CatalogueItem(
          catalogue: catalogue,
          onTap: () => _goToCatalogueDetails(context, catalogue),
        );
      },
    );
  }

  _goToCatalogueDetails(BuildContext context, Catalogue catalogue) {
    context.pushNamed(
      CatalogueDetailScreen.name,
      pathParameters: {
        'catalogueId': catalogue.id,
      },
    );
  }
}
