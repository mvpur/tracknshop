import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/catalogue.dart';
import 'package:track_shop_app/entities/category.dart';
import 'package:track_shop_app/presentation/provider/catalogue_provider.dart';
import 'package:track_shop_app/presentation/provider/item_provider.dart';
import 'package:track_shop_app/presentation/widgets/category_utils/assign_catalogue_dialog.dart';

class WarehouseDetailView extends ConsumerWidget {
  final List<Category> categories;

  const WarehouseDetailView({super.key, required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemProvider);
    final catalogues = ref.watch(catalogueProvider);

    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        const SizedBox(height: 16),
        if (categories.isNotEmpty)
          ...categories.map((category) {
            final filteredItems =
                items.where((item) => item.categoryId == category.id).toList();

            return ExpansionTile(
              title: GestureDetector(
                onTap: () =>
                    _assignCatalogue(context, catalogues, category, ref),
                child: Text(category.name),
              ),
              children: [
                if (filteredItems.isEmpty)
                  const ListTile(title: Text('No items available'))
                else
                  ...filteredItems.map((item) => ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.name),
                            Text(
                              item.amount != null && item.typeAmount != null
                                  ? '${item.amount}-${item.typeAmount}'
                                  : '—',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      )),
              ],
            );
          })
        else
          const Center(child: Text('No categories available')),
      ],
    );
  }

  void _assignCatalogue(BuildContext context, List<Catalogue> catalogues,
      Category category, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AssignCatalogueDialog(
          catalogues: catalogues,
          categoryId: category.id,
          ref: ref,
        );
      },
    );
  }
}