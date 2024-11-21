import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/catalogue.dart';
import 'package:track_shop_app/entities/category.dart';
import 'package:track_shop_app/presentation/provider/catalogue_provider.dart';
import 'package:track_shop_app/presentation/provider/category_provider.dart';
import 'package:track_shop_app/presentation/provider/item_provider.dart';
import 'package:track_shop_app/presentation/screens/category/delete_category_confirmation.dart';
import 'package:track_shop_app/presentation/screens/item/delete_item_confirmation.dart';
import 'package:track_shop_app/presentation/screens/item/edit_item_dialog.dart';
import 'package:track_shop_app/presentation/widgets/utils/category_utils/assign_catalogue_dialog.dart';

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
            final filteredItems = items
                .where((item) =>
                    (item.categoryId == category.id && item.isCompleted))
                .toList();

            return ExpansionTile(
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () =>
                        _assignCatalogue(context, catalogues, category, ref),
                    child: Text(
                      category.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () async {
                      final confirm = await _showDeleteCategoryConfirmation(
                          context, category, ref);
                      if (confirm == true) {
                        ref
                            .read(categoryProvider.notifier)
                            .deleteCategory(category.id);
                      }
                    },
                  ),
                ],
              ),
              children: [
                if (filteredItems.isEmpty)
                  const ListTile(title: Text('No items available'))
                else
                  ...filteredItems.map((item) => ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showEditItemDialog(context, ref, item);
                              },
                              child: Text(item.name),
                            ),
                            GestureDetector(
                              onTap: () {
                                showEditItemDialog(context, ref, item);
                              },
                              child: Text(
                                item.amount != null && item.typeAmount != null
                                    ? '${item.amount} - ${item.typeAmount?.toUpperCase()}'
                                    : '—',
                                style: TextStyle(color: Colors.grey.shade600),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                final confirm =
                                    await showDeleteConfirmationDialog(
                                  context: context,
                                  itemName: item.name,
                                );

                                if (confirm == true) {
                                  await ref
                                      .read(itemProvider.notifier)
                                      .deleteItem(item.id);
                                }
                              },
                              icon: const Icon(Icons.close),
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

  Future<bool> _showDeleteCategoryConfirmation(
      BuildContext context, Category category, WidgetRef ref) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            return DeleteCategoryConfirmationDialog(
              onCancel: () => Navigator.of(context).pop(false),
              onConfirm: () {},
            );
          },
        ) ??
        false;
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
