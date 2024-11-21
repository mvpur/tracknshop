import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/category.dart';
import 'package:track_shop_app/entities/warehouse.dart';
import 'package:track_shop_app/presentation/provider/item_provider.dart';
import 'package:track_shop_app/presentation/provider/warehouse_provider.dart';
import 'package:track_shop_app/presentation/widgets/category_utils/assign_warehouse_dialog.dart';
import 'package:track_shop_app/presentation/widgets/category_utils/item_with_checkbox.dart';
import 'package:track_shop_app/presentation/screens/category/delete_category_confirmation.dart';
import 'package:track_shop_app/presentation/provider/catalogue_provider.dart';

class CategoryDetailView extends ConsumerWidget {
  final List<Category> categories;

  const CategoryDetailView({super.key, required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemProvider);
    final warehouses = ref.watch(warehouseProvider);

    return ListView(
      padding: const EdgeInsets.all(8.0),
      children: [
        const SizedBox(height: 16),
        if (categories.isNotEmpty)
          ...categories.map((category) {
            final filteredItems =
                items.where((item) => item.categoryId == category.id).toList();

            return ExpansionTile(
              title: Row(
                children: [
                  GestureDetector(
                    onTap: () =>
                        _assignWarehouse(context, warehouses, category, ref),
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
                        // Llamar a la función para eliminar la categoría
                        ref
                            .read(catalogueProvider.notifier)
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
                  ...filteredItems.map((item) {
                    return ItemWithCheckbox(item: item);
                  }),
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
              onConfirm:
                  () {}, // Puede quedar vacío, ya que la eliminación la manejamos en el callback
            );
          },
        ) ??
        false;
  }

  void _assignWarehouse(BuildContext context, List<Warehouse> warehouses,
      Category category, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        return AssignWarehouseDialog(
          warehouses: warehouses,
          categoryId: category.id,
          ref: ref,
        );
      },
    );
  }
}
